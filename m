MIME-Version: 1.0
Date: Thu, 30 Apr 2009 10:43:02 -0500
Message-ID: <4313f3060904300843ra2f7a71o37f39780a797cfd2@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: multipart/mixed; boundary=0016e6464f7227fe860468c78d3f
Subject: [B.A.T.M.A.N.] times wrapper
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <B.A.T.M.A.N@open-mesh.net>

--0016e6464f7227fe860468c78d3f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

When I first started meshing, I used olsrd.  There was a problem on
our platform that caused olsrd packets to stop going out after the
board had been up about 5 minutes.  The outage lasted about 40
seconds, then came back.  It turns out that there is a problem with
the times() call that will return -1 for the 4096 jiffies before wrap
around.  This caused no apparent change in time during that duration,
so no packets were sent.  Also, for some reason on our platform,
times() starts out about 5 minutes before wrap around.

I found a work around elsewhere (and I leave credit in the patch) for
some other software that was failing every 400 something days.  I
applied this to olsrd, and the problem went away.

When I switched to batman, I saw that times() is used in it as well,
so I made the patch attached.  So, if anyone sees packets fail to come
from batman for 40 seconds, they might need this.

--0016e6464f7227fe860468c78d3f
Content-Type: application/octet-stream; name="001-times.patch"
Content-Disposition: attachment; filename="001-times.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu5mh3y20

ZGlmZiAtcnVOIGJhdG1hbmQtcjExNzgub3JpZy9wb3NpeC9wb3NpeC5jIGJhdG1hbmQtcjExNzgv
cG9zaXgvcG9zaXguYwotLS0gYmF0bWFuZC1yMTE3OC5vcmlnL3Bvc2l4L3Bvc2l4LmMJMjAwOC0x
Mi0yOSAwOTozNTozOC4wMDAwMDAwMDAgLTA2MDAKKysrIGJhdG1hbmQtcjExNzgvcG9zaXgvcG9z
aXguYwkyMDA5LTAxLTAyIDEzOjMxOjI3LjAwMDAwMDAwMCAtMDYwMApAQCAtNDksMTEgKzQ5LDQ5
IEBACiAKIHN0YXRpYyBwdGhyZWFkX211dGV4X3QgYmF0bWFuX2Nsb2NrX211dGV4ID0gUFRIUkVB
RF9NVVRFWF9JTklUSUFMSVpFUjsKIAorc3RhdGljIHN0cnVjdCB0bXMgZHVtbXlfdG1zX3N0cnVj
dDsKK3N0YXRpYyBjbG9ja190Cit0aW1lc193cmFwcGVyKHZvaWQpIC8qIE1ha2UgdGltZXMoMikg
YmVoYXZlIHJhdGlvbmFsbHkgb24gTGludXggKi8KK3sKKyAgICAgICBpbnQgICAgICAgICAgICAg
c2F2ZV9lcnJubyA9IGVycm5vOworICAgICAgIGNsb2NrX3QgcmV0OworCisgICAgICAgLyoKKyAg
ICAgICAgKiB0aW1lcygyKSByZWFsbHkgcmV0dXJucyBhbiB1bnNpZ25lZCB2YWx1ZSAuLi4KKyAg
ICAgICAgKgorICAgICAgICAqIFdlIGRvbid0IGNoZWNrIHRvIHNlZSBpZiB3ZSBnb3QgYmFjayB0
aGUgZXJyb3IgdmFsdWUgKC0xKSwgYmVjYXVzZQorICAgICAgICAqIHRoZSBvbmx5IHBvc3NpYmls
aXR5IGZvciBhbiBlcnJvciB3b3VsZCBiZSBpZiB0aGUgYWRkcmVzcyBvZgorICAgICAgICAqIGR1
bW15X3Rtc19zdHJ1Y3Qgd2FzIGludmFsaWQuICBTaW5jZSBpdCdzIGEKKyAgICAgICAgKiBjb21w
aWxlci1nZW5lcmF0ZWQgYWRkcmVzcywgd2UgYXNzdW1lIHRoYXQgZXJyb3JzIGFyZSBpbXBvc3Np
YmxlLgorICAgICAgICAqIEFuZCwgdW5mb3J0dW5hdGVseSwgaXQgaXMgcXVpdGUgcG9zc2libGUg
Zm9yIHRoZSBjb3JyZWN0IHJldHVybgorICAgICAgICAqIGZyb20gdGltZXMoMikgdG8gYmUgZXhh
Y3RseSAoY2xvY2tfdCktMS4gIFNpZ2guLi4KKyAgICAgICAgKgorICAgICAgICAqLworICAgICAg
IGVycm5vICAgPSAwOworICAgICAgIHJldCAgICAgPSB0aW1lcygmZHVtbXlfdG1zX3N0cnVjdCk7
CisKKy8qCisgKiAgICAgVGhpcyBpcyB0byB3b3JrIGFyb3VuZCBhIGJ1ZyBpbiB0aGUgc3lzdGVt
IGNhbGwgaW50ZXJmYWNlCisgKiAgICAgZm9yIHRpbWVzKDIpIGZvdW5kIGluIGdsaWJjIG9uIExp
bnV4IChhbmQgbWF5YmUgZWxzZXdoZXJlKQorICogICAgIEl0IGNoYW5nZXMgdGhlIHJldHVybiB2
YWx1ZXMgZnJvbSAtMSB0byAtNDA5NiBhbGwgaW50bworICogICAgIC0xIGFuZCB0aGVuIGR1bXBz
IHRoZSAtKHJldHVybiB2YWx1ZSkgaW50byBlcnJuby4KKyAqCisgKiAgICAgVGhpcyB0b3RhbGx5
IGJpemFycmUgYmVoYXZpb3Igc2VlbXMgdG8gYmUgd2lkZXNwcmVhZCBpbgorICogICAgIHZlcnNp
b25zIG9mIExpbnV4IGFuZCBnbGliYy4KKyAqCisgKiAgICAgTWFueSB0aGFua3MgdG8gV29sZmdh
bmcgRHVtaHMgPHdvbGZnYW5nLmR1bWhzIChhdCkgZ214LmF0PgorICogICAgIGZvciBmaW5kaW5n
IGFuZCBkb2N1bWVudGluZyB0aGlzIGJpemFycmUgYmVoYXZpb3IuCisgKi8KKyAgICAgICBpZiAo
ZXJybm8gIT0gMCkgeworICAgICAgICAgICAgICAgcmV0ID0gKGNsb2NrX3QpICgtZXJybm8pOwor
ICAgICAgIH0KKyAgICAgICBlcnJubyA9IHNhdmVfZXJybm87CisgICAgICAgcmV0dXJuIHJldDsK
K30KIAogc3RhdGljIHZvaWQgdXBkYXRlX2ludGVybmFsX2Nsb2NrKHZvaWQpCiB7Ci0Jc3RydWN0
IHRtcyB0cDsKLQljbG9ja190IGN1cnJlbnRfY2xvY2tfdGljayA9IHRpbWVzKCZ0cCk7CisJY2xv
Y2tfdCBjdXJyZW50X2Nsb2NrX3RpY2sgPSB0aW1lc193cmFwcGVyKCk7CiAKIAliYXRtYW5fY2xv
Y2tfdGlja3MgKz0gKGN1cnJlbnRfY2xvY2tfdGljayAtIGxhc3RfY2xvY2tfdGljayk7CiAJbGFz
dF9jbG9ja190aWNrID0gY3VycmVudF9jbG9ja190aWNrOwpAQCAtNTUzLDcgKzU5MSw2IEBACiBp
bnQgbWFpbiggaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSApIHsKIAogCWludDhfdCByZXM7Ci0Jc3Ry
dWN0IHRtcyB0cDsKIAogCS8qIGNoZWNrIGlmIHVzZXIgaXMgcm9vdCAqLwogCWlmICggKCBnZXR1
aWQoKSApIHx8ICggZ2V0Z2lkKCkgKSApIHsKQEAgLTU3NSw3ICs2MTIsNyBAQAogCiAJLyogc2F2
ZSBzdGFydCB2YWx1ZSAqLwogCXN5c3RlbV90aWNrID0gKGZsb2F0KXN5c2NvbmYoX1NDX0NMS19U
Q0spOwotCWxhc3RfY2xvY2tfdGljayA9IHRpbWVzKCZ0cCk7CisJbGFzdF9jbG9ja190aWNrID0g
dGltZXNfd3JhcHBlcigpOwogCXVwZGF0ZV9pbnRlcm5hbF9jbG9jaygpOwogCiAJYXBwbHlfaW5p
dF9hcmdzKCBhcmdjLCBhcmd2ICk7Cg==
--0016e6464f7227fe860468c78d3f--
