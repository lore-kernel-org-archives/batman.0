Return-Path: <paukoning@gmail.com>
MIME-Version: 1.0
Date: Mon, 24 Dec 2012 15:38:21 +0100
Message-ID: <CANiGF98hyN7yvSHNJ8zkicnZ4hJREYKEw7FPsL6JOEoT8ykvqw@mail.gmail.com>
From: Pau Koning <paukoning@gmail.com>
Content-Type: multipart/mixed; boundary=f46d044303541dc13204d19a26e2
Subject: [B.A.T.M.A.N.] batctl: Fix undefined macro warning in manpage
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--f46d044303541dc13204d19a26e2
Content-Type: text/plain; charset=ISO-8859-1

A line beginning with ' or . in a groff file has a special meaning and
cannot be used for literal text. Instead the interpreter will try to
execute it and fail doing so. A zero-width space or reformatting the
paragraph can be used as simple workaround.

This problem was detected using: LC_ALL=en_US.UTF-8 MANROFFSEQ=''
MANWIDTH=80 man --warnings -E UTF-8 -l -Tutf8 -Z man/batctl.8
>/dev/null

--f46d044303541dc13204d19a26e2
Content-Type: application/octet-stream; name="man_warning.patch"
Content-Disposition: attachment; filename="man_warning.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hb3pjghv0

ZGlmZiAtLWdpdCBhL21hbi9iYXRjdGwuOCBiL21hbi9iYXRjdGwuOAotLS0gYS9tYW4vYmF0Y3Rs
LjgKKysrIGIvbWFuL2JhdGN0bC44CkBAIC05Niw3ICs5Niw3IEBAIHJlcGxhY2UgdGhlIE1BQyBh
ZGRyZXNzZXMgd2l0aCBiYXRcLWhvc3QgbmFtZXMgaW4gdGhlIG91dHB1dC4KIC5JUCAiXGZCZ3df
bW9kZXxnd1xmUCBbXGZCb2ZmXGZQfFxmQmNsaWVudFxmUHxcZkJzZXJ2ZXJcZlBdIFtcZkJzZWxf
Y2xhc3N8YmFuZHdpZHRoXGZQXVxmUCIKIElmIG5vIHBhcmFtZXRlciBpcyBnaXZlbiB0aGUgY3Vy
cmVudCBnYXRld2F5IG1vZGUgaXMgZGlzcGxheWVkIG90aGVyd2lzZSB0aGUgcGFyYW1ldGVyIGlz
IHVzZWQgdG8gc2V0IHRoZSBnYXRld2F5IG1vZGUuIFRoZQogc2Vjb25kIChvcHRpb25hbCkgYXJn
dW1lbnQgc3BlY2lmaWVzIHRoZSBzZWxlY3Rpb24gY2xhc3MgKGlmICdjbGllbnQnIHdhcyB0aGUg
Zmlyc3QgYXJndW1lbnQpIG9yIHRoZSBnYXRld2F5IGJhbmR3aWR0aCAoaWYKLSdzZXJ2ZXInIHdh
cyB0aGUgZmlyc3QgYXJndW1lbnQpLiBJZiB0aGUgbm9kZSBpcyBhIHNlcnZlciB0aGlzIHBhcmFt
ZXRlciBpcyB1c2VkIHRvIGluZm9ybSBvdGhlciBub2RlcyBpbiB0aGUgbmV0d29yayBhYm91dAor
XCYnc2VydmVyJyB3YXMgdGhlIGZpcnN0IGFyZ3VtZW50KS4gSWYgdGhlIG5vZGUgaXMgYSBzZXJ2
ZXIgdGhpcyBwYXJhbWV0ZXIgaXMgdXNlZCB0byBpbmZvcm0gb3RoZXIgbm9kZXMgaW4gdGhlIG5l
dHdvcmsgYWJvdXQKIHRoaXMgbm9kZSdzIGludGVybmV0IGNvbm5lY3Rpb24gYmFuZHdpZHRoLiBK
dXN0IGVudGVyIGFueSBudW1iZXIgKG9wdGlvbmFsbHkgZm9sbG93ZWQgYnkgImtiaXQiIG9yICJt
Yml0IikgYW5kIHRoZSBiYXRtYW4tYWR2CiBtb2R1bGUgd2lsbCBndWVzcyB5b3VyIGFwcHJvcHJp
YXRlIGdhdGV3YXkgY2xhc3MuIFVzZSAiLyIgdG8gc2VwYXJhdGUgdGhlIGRvd25cKGh5IGFuZCB1
cGxvYWQgcmF0ZXMuIFlvdSBjYW4gb21pdCB0aGUgdXBsb2FkCiByYXRlIGFuZCB0aGUgbW9kdWxl
IHdpbGwgYXNzdW1lIGFuIHVwbG9hZCBvZiBkb3dubG9hZCAvIDUuCg==
--f46d044303541dc13204d19a26e2--
