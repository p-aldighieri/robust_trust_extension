"""Mistral OCR wrapper: upload a PDF, get markdown back."""

import base64
import json
import os
import sys
import urllib.request
import urllib.error


API_KEY = os.environ["MISTRAL_API_KEY"]
BASE = "https://api.mistral.ai/v1"


def _req(method, path, body=None, headers=None):
    h = {"Authorization": f"Bearer {API_KEY}"}
    if headers:
        h.update(headers)
    data = None
    if body is not None:
        if isinstance(body, (dict, list)):
            data = json.dumps(body).encode()
            h.setdefault("Content-Type", "application/json")
        else:
            data = body
    req = urllib.request.Request(BASE + path, data=data, method=method, headers=h)
    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as e:
        raise SystemExit(f"HTTP {e.code} {path}: {e.read().decode()}")


def upload(path):
    """Upload a file for OCR. Multipart form-data."""
    boundary = "----mistralboundary"
    fname = os.path.basename(path)
    with open(path, "rb") as f:
        content = f.read()
    parts = []
    parts.append(f"--{boundary}\r\n".encode())
    parts.append(b'Content-Disposition: form-data; name="purpose"\r\n\r\n')
    parts.append(b"ocr\r\n")
    parts.append(f"--{boundary}\r\n".encode())
    parts.append(
        f'Content-Disposition: form-data; name="file"; filename="{fname}"\r\n'.encode()
    )
    parts.append(b"Content-Type: application/pdf\r\n\r\n")
    parts.append(content)
    parts.append(f"\r\n--{boundary}--\r\n".encode())
    body = b"".join(parts)
    headers = {"Content-Type": f"multipart/form-data; boundary={boundary}"}
    return _req("POST", "/files", body=body, headers=headers)


def signed_url(file_id):
    return _req("GET", f"/files/{file_id}/url?expiry=24")


def ocr(document_url):
    return _req(
        "POST",
        "/ocr",
        body={
            "model": "mistral-ocr-latest",
            "document": {"type": "document_url", "document_url": document_url},
            "include_image_base64": False,
        },
    )


def main(pdf_path, out_md_path):
    print(f"[1/3] uploading {pdf_path}", flush=True)
    up = upload(pdf_path)
    fid = up["id"]
    print(f"      file_id={fid}", flush=True)
    print(f"[2/3] getting signed URL", flush=True)
    su = signed_url(fid)
    print(f"[3/3] running OCR", flush=True)
    res = ocr(su["url"])
    pages = res.get("pages", [])
    md = "\n\n---\n\n".join(p.get("markdown", "") for p in pages)
    with open(out_md_path, "w", encoding="utf-8") as f:
        f.write(md)
    print(f"      wrote {out_md_path} ({len(md)} chars, {len(pages)} pages)", flush=True)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage: mistral_ocr.py INPUT.pdf OUTPUT.md", file=sys.stderr)
        raise SystemExit(2)
    main(sys.argv[1], sys.argv[2])
