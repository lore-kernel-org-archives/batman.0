Return-Path: <jhaws@sdl.usu.edu>
From: Jonathan Haws <jhaws@sdl.usu.edu>
Date: Wed, 24 Oct 2018 19:20:21 +0000
Message-ID: <9df1a2a9a3c9a31aed98eb9cc623a57fd68134fa.camel@sdl.usu.edu>
References: <20181024183511.19902-1-jhaws@sdl.usu.edu>
 <7302424.rEnkhXZBE4@sven-edge>
In-Reply-To: <7302424.rEnkhXZBE4@sven-edge>
Reply-To: Jonathan Haws <jhaws@sdl.usu.edu>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <74E6FB13FA770149A2DC735E1571C948@sdl.usu.edu>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH alfred] Request MAC resolution for IPv4
 address not in ARP cache
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "sven@narfation.org" <sven@narfation.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

T24gV2VkLCAyMDE4LTEwLTI0IGF0IDIwOjU3ICswMjAwLCBTdmVuIEVja2VsbWFubiB3cm90ZToN
Cj4gUGxlYXNlIHN0YXJ0IHRoZSBzdWJqZWN0IHdpdGggImFsZnJlZDogIiB3aGVuIGl0IGlzIGEg
cGF0Y2ggZm9yDQo+IGFsZnJlZC4NCg0KUmlnaHQgLSBteSBtaXN0YWtlLiBJdCdzIGJlZW4gYSBs
b25nIHRpbWUgc2luY2UgSSBsYXN0IHN1Ym1pdHRlZC4uLi4NCg0KPiANCj4gT24gTWl0dHdvY2gs
IDI0LiBPa3RvYmVyIDIwMTggMjA6MzU6MTEgQ0VTVCBKb25hdGhhbiBIYXdzIHdyb3RlOg0KPiA+
IFdoZW4gdXNpbmcgSVB2NCwgaWYgdGhlIHJlbW90ZSBzZXJ2ZXIgaXMgbm90IHlldCBpbiB0aGUg
QVJQIGNhY2hlLA0KPiA+IHRoZQ0KPiA+IE1BQyByZXNvbHV0aW9uIHdpbGwgZmFpbCBhbmQgZGF0
YSBhcHBlYXIgdG8gbm90IGJlIHNoYXJlZCB2aWENCj4gPiBhbGZyZWQuDQo+ID4gQWRkIGEgcm91
dGluZSAobW9kaWZpZWQgZnJvbSBiYXRjdGwgc291cmNlcykgdG8gcmVxdWVzdCBNQUMNCj4gPiBy
ZXNvbHV0aW9uDQo+ID4gYnkgc2ltcGx5IHNlbmRpbmcgYSBkYXRhZ3JhbSB0byB0aGUgZGlzY2Fy
ZCBwb3J0IChVRFAvOSkuIFRoaXMgYWRkcw0KPiA+IHRoZQ0KPiA+IHJlbW90ZSBNQUMgdG8gdGhl
IEFSUCBjYWNoZSwgcmVzdWx0aW5nIGluIHN1Y2Nlc3NmdWwgTUFDDQo+ID4gcmVzb2x1dGlvbi4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBIYXdzIDxqaGF3c0BzZGwudXN1LmVk
dT4NCj4gDQo+IFBsZWFzZSBhZGQgdGhlIGluZm8gd2hpY2ggY29tbWl0IHdhcyBmaXhlZCBieSB0
aGlzIGNoYW5nZSByaWdodA0KPiBiZWZvcmUgDQo+IHRoZSBTaWduZWQtb2ZmLWJ5Og0KPiANCj4g
Rml4ZXM6IGM3ZGE3OTgxMTNhMiAoImFsZnJlZDogSVB2NCBtdWx0aWNhc3QgZGlzdHJpYnV0aW9u
IHN1cHBvcnQuIikNCj4gDQoNCkRvbmUuDQoNCj4gWy4uLl0NCj4gPiBpbmRleCBlZWNmZGZkLi41
NzcxNDgzIDEwMDY0NA0KPiA+IC0tLSBhL2FsZnJlZC5oDQo+ID4gKysrIGIvYWxmcmVkLmgNCj4g
PiBAQCAtMjEzLDMgKzIxMyw0IEBAIHVpbnQxNl90IGdldF9yYW5kb21faWQodm9pZCk7DQo+ID4g
IGJvb2wgaXNfdmFsaWRfZXRoZXJfYWRkcih1aW50OF90ICphZGRyKTsNCj4gPiAgaW50IGlwdjRf
YXJwX3JlcXVlc3Qoc3RydWN0IGludGVyZmFjZSAqaW50ZXJmYWNlLCBjb25zdA0KPiA+IGFsZnJl
ZF9hZGRyICphZGRyLA0KPiA+ICAJCSAgICAgc3RydWN0IGV0aGVyX2FkZHIgKm1hYyk7DQo+ID4g
K3ZvaWQgaXB2NF9yZXF1ZXN0X21hY19yZXNvbHZlKGNvbnN0IGFsZnJlZF9hZGRyICphZGRyKTsN
Cj4gDQo+IFRoaXMgZG9lc24ndCBtYWtlIHNlbnNlLiBUaGUgZnVuY3Rpb24gaXMgaW4gdXRpbC5j
IGFuZCBvbmx5IGNhbGxlZCBpbg0KPiB1dGlsLmMuIA0KPiBTbyBpdCBzaG91bGQgYmUgc3RhdGlj
IGFuZCBub3QgaW4gdGhpcyBoZWFkZXIgYXQgYWxsLg0KDQpZb3UncmUgcmlnaHQgLSBJIGJsaW5k
bHkgbWltaWNrZWQgdGhlIHByZXZpb3VzIGlwdjRfYXJwX3JlcXVlc3Qgcm91dGluZQ0Kd2l0aG91
dCB0aGlua2luZyBhYm91dCBpdC4NCg0KRml4ZWQgaW4gdjIuDQoNCnYyIGZvcnRoY29taW5nLi4u
DQoNCg0K
