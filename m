Return-Path: <David.Laight@ACULAB.COM>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 9 Oct 2013 17:19:44 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7386@saturn3.aculab.com>
In-Reply-To: <20131009161028.GI3544@neomailbox.net>
References: <1381322418-1349-1-git-send-email-antonio@meshcoding.com>
 <1381322418-1349-11-git-send-email-antonio@meshcoding.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7384@saturn3.aculab.com>
 <20131009143500.GH3544@neomailbox.net>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7385@saturn3.aculab.com>
 <20131009161028.GI3544@neomailbox.net>
From: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/16] batman-adv: use CRC32C instead of
	CRC16 in TT code
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, davem@davemloft.net, Antonio Quartulli <ordex@autistici.org>

PiBPbiBXZWQsIE9jdCAwOSwgMjAxMyBhdCAwNDo0OTo1M1BNICswMTAwLCBEYXZpZCBMYWlnaHQg
d3JvdGU6DQo+ID4gPiA+IEFyZSB5b3UgcmVhbGx5IGdlbmVyYXRpbmcgQ1JDMzIgb2YgYSBwaWxl
IG9mIGV0aGVybmV0IE1BQyBhZGRyZXNzZXMNCj4gPiA+ID4gYW5kIHRoZSBYT1JpbmcgdGhlIENS
QyB0b2dldGhlcj8NCj4gPiA+ID4gVGhhdCBnaXZlcyB0aGUgc2FtZSBhbnN3ZXIgYXMgWE9SaW5n
IHRvZ2V0aGVyIHRoZSBNQUMgYWRkcmVzc2VzIGFuZA0KPiA+ID4gPiB0aGVuIGRvaW5nIGEgQ1JD
IG9mIHRoZSBmaW5hbCB2YWx1ZS4NCj4gPiA+DQo+ID4gPiBJIHdhcyBub3Qgc3VyZSBhYm91dCB0
aGlzIHNpbmNlIHRoZSBDUkMzMiBpcyBub3QgYSBsaW5lYXIgb3BlcmF0aW9uLiBIb3dldmVyDQo+
ID4gPiB0aGlzIHJvdXRpbmUgaXMgbm90IG9uIHRoZSBmYXN0IHBhdGgsIHNvIHdlIGNhbiBhbHNv
IGxpdmUgd2l0aCB0aGlzIG9yZGVyLg0KPiA+DQo+ID4gQWxsIENSQyBhcmUgbGluZWFyLg0KPiA+
IEJlY2F1c2UgJyhhICsgYikgbW9kIGMnIGlzIHRoZSBzYW1lIGFzICcoKGEgbW9kIGMpICsgKGIg
bW9kIGMpKSBtb2QgYycuDQo+ID4NCj4gPiBUaGUgQ1JDIG9mIGEgYnVmZmVyIGlzIHRoZSBYT1Ig
b2YgdGhlIENSQ3MgZ2VuZXJhdGVkIGZvciBlYWNoICcxJyBiaXQuDQo+ID4gVGhlIENSQyBmb3Ig
ZWFjaCBiaXQgZGVwZW5kcyBvbiBob3cgZmFyIGl0IGlzIGZyb20gdGhlIGVuZCBvZiB0aGUgYnVm
ZmVyLg0KPiANCj4gSW4gb3VyIHRhYmxlcyB3ZSBjYW5ub3QgbWFrZSBhbnkgYXNzdW1wdGlvbiBh
Ym91dCB0aGUgb3JkZXIgb2YgdGhlIGVudHJpZXM6IHRoZQ0KPiBub2RlIHdob20gZ2VuZXJhdGVk
IHRoZSB0YWJsZSBtYXkgc3RvcmUgdGhlIGVudHJpZXMgaW4gYSBkaWZmZXJlbnQgb3JkZXIgZnJv
bQ0KPiB3aGF0IHdlIGhhdmUgZ290Lg0KPiBUaGlzIGlzIHdoeSBJIGRpZCBub3QgaW1wbGVtZW50
ZWQgaXQgYXMgYSBzaW1wbGUgQ1JDIG9mIHRoZQ0KPiB3aG9sZSB0aGUgR2xvYmFsVGFibGUvYnVm
ZmVyIGJ1dCBJIENSQydkIGVhY2ggTUFDK1ZJRCBvbiBpdHMgb3duLg0KPiANCi4uLg0KPiANCj4g
QXNzdW1pbmcgd2hhdCBJIHNhaWQgYWJvdmUgKHRoYXQgd2UgY2Fubm90IG1ha2UgYXNzdW1wdGlv
bnMgb24gdGhlIG9yZGVyIG9mIHRoZQ0KPiBlbnRyaWVzKSwgd2hhdCBpcyB5b3VyIHN1Z2dlc3Rp
b24/DQoNCkknbSBub3Qgc3VyZSB3aGF0IHlvdSBhcmUgdXNpbmcgdGhpcyBDUkMgZm9yLg0KSWYg
eW91IGFyZSB0cnlpbmcgdG8gdXNlIGl0IHRvIGNoZWNrIHRoYXQgdGhlIHR3byB0YWJsZXMgbWF0
Y2ggLSBzbyBhDQpmdWxsIHVwZGF0ZSBpc24ndCBuZWVkZWQgdGhlbiBpdCBqdXN0IHdvbid0IHdv
cmsuDQoNCklmIHlvdSB0YWtlIG91dCAxMToyMjozMzo0NDo1NTo2MCBhbmQgMTE6MjI6MzM6NDQ6
NTU6NjEgYW5kDQpjaGFuZ2UgOTk6ODg6Nzc6NjY6NTU6NDAgdG8gOTk6ODg6Nzc6NjY6NTU6NDEg
dGhlbiB0aGUgWE9SIG9mDQp0aGUgQ1JDcyB3b24ndCBjaGFuZ2UuDQpGb3IgTUFDIGFkZHJlc3Nl
cyBzdWNoIGNoYW5nZXMgYXJlbid0IHRoYXQgdW5saWtlbHkuDQoNCglEYXZpZA0KDQo=
