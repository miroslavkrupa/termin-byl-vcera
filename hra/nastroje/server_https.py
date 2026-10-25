#!/usr/bin/env python3
"""Podává webový export hry přes HTTPS, aby šel vyzkoušet na telefonu ve stejné Wi-Fi.

Godot na webu vyžaduje zabezpečený kontext (HTTPS nebo localhost), adresa Macu ve Wi-Fi přes HTTP
nestačí. Certifikát je vlastnoručně podepsaný, telefon proto napoprvé zobrazí varování, které je
potřeba potvrdit.

Spuštění z kořene repozitáře:  python3 hra/nastroje/server_https.py [port]
Certifikát (platný 30 dní) vytvoří:
  openssl req -x509 -newkey rsa:2048 -nodes -days 30 -keyout hra/export/certifikat/klic.pem \\
    -out hra/export/certifikat/certifikat.pem -subj "/CN=<IP Macu>" -addext "subjectAltName=IP:<IP Macu>"
"""
import functools
import http.server
import pathlib
import socket
import ssl
import sys

EXPORT = pathlib.Path(__file__).resolve().parent.parent / "export"
port = int(sys.argv[1]) if len(sys.argv) > 1 else 8791

handler = functools.partial(http.server.SimpleHTTPRequestHandler, directory=str(EXPORT / "web"))
server = http.server.ThreadingHTTPServer(("0.0.0.0", port), handler)
kontext = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
kontext.load_cert_chain(EXPORT / "certifikat" / "certifikat.pem", EXPORT / "certifikat" / "klic.pem")
server.socket = kontext.wrap_socket(server.socket, server_side=True)

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
print(f"Hra běží na https://{s.getsockname()[0]}:{port}  (na Macu https://localhost:{port})")
s.close()
server.serve_forever()
