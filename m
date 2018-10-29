Return-Path: <jhaws@sdl.usu.edu>
From: Jonathan Haws <jhaws@sdl.usu.edu>
Date: Mon, 29 Oct 2018 17:55:02 +0000
Message-ID: <c25bf8be883a9252b43c8cc4197276390ce77fa1.camel@sdl.usu.edu>
References: <20181029170542.5406-1-sven@narfation.org>
In-Reply-To: <20181029170542.5406-1-sven@narfation.org>
Reply-To: Jonathan Haws <jhaws@sdl.usu.edu>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <963B262A26E0E74F887001B8F34EA940@sdl.usu.edu>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] alfred: Fix detection of own
 packets for IPv4 mode
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

VGVzdGVkIEJ5OiBKb25hdGhhbiBIYXdzIDxqaGF3c0BzZGwudXN1LmVkdT4NCg0KT24gTW9uLCAy
MDE4LTEwLTI5IGF0IDE4OjA1ICswMTAwLCBTdmVuIEVja2VsbWFubiB3cm90ZToNCj4gVGhlIGlu
Y29taW5nIHBhY2tldCBhZGRyZXNzIGlzIGNoZWNrZWQgZm9yIGEgbWF0Y2ggYWdhaW5zdCB0aGUg
bG9jYWwNCj4gaW50ZXJmYWNlIGFkZHJlc3NlcyB0byBhdm9pZCBwcm9jZXNzaW5nIGl0cyBvd24g
cGFja2V0cy4gVGhlIElQdjQNCj4gaW1wbGVtZW50YXRpb24gdXNlZCB0aGUgc2FtZSBjb2RlIGJ1
dCBvbmx5IGluaXRpYWxpemVkIDQgb2YgdGhlIDE2DQo+IGJ5dGVzIG9mDQo+IHRoZSBhZGRyZXNz
IGluIHRoZSByZWN2IGZ1bmN0aW9uLiBUaGUgaW50ZXJmYWNlIGluaXRpYWxpemF0aW9uIGNvZGUN
Cj4gaW4NCj4gbmV0c29ja19zZXRfaW50ZXJmYWNlcyBzZXQgYWxsIHVudXNlZCBieXRlcyB0byB6
ZXJvIGJ1dA0KPiByZWN2X2FsZnJlZF9wYWNrZXQNCj4gd2FzIG1vZGlmaWVkIHRvIHVzZSAxMiBy
YW5kb20gYnl0ZXMgZnJvbSB0aGUgc3RhY2suDQo+IA0KPiBCb3RoIGZ1bmN0aW9ucyBtdXN0IHdv
cmsgdGhlIHNhbWUgd2F5IGFuZCBmaXJzdCBzZXQgdGhlIGFkZHJlc3MgYnl0ZXMNCj4gdG8NCj4g
emVybyBhbmQgb3ZlcndyaXRlIHRoZSBhY3R1YWwgdXNlZCBieXRlcyB3aXRoIHRoZSBhZGRyZXNz
IGJ5dGVzLg0KPiBPdGhlcndpc2UsDQo+IHRoZSByZXN1bHQgb2YgbmV0c29ja19zZXRfaW50ZXJm
YWNlcyBmb3Igb3duIHBhY2tldHMgaXMgcmFuZG9tIGluIHRoZQ0KPiBJUHY0DQo+IGltcGxlbWVu
dGF0aW9uLg0KPiANCj4gRml4ZXM6IGM3ZGE3OTgxMTNhMiAoImFsZnJlZDogSVB2NCBtdWx0aWNh
c3QgZGlzdHJpYnV0aW9uIHN1cHBvcnQuIikNCj4gU2lnbmVkLW9mZi1ieTogU3ZlbiBFY2tlbG1h
bm4gPHN2ZW5AbmFyZmF0aW9uLm9yZz4NCj4gLS0tDQo+IENjOiBKb25hdGhhbiBIYXdzIDxqaGF3
c0BzZGwudXN1LmVkdT4NCj4gLS0tDQo+ICByZWN2LmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY3YuYyBiL3JlY3YuYw0KPiBp
bmRleCA1OWQ3NTljLi41ZmY0YmI1IDEwMDY0NA0KPiAtLS0gYS9yZWN2LmMNCj4gKysrIGIvcmVj
di5jDQo+IEBAIC00MTYsNiArNDE2LDcgQEAgaW50IHJlY3ZfYWxmcmVkX3BhY2tldChzdHJ1Y3Qg
Z2xvYmFscyAqZ2xvYmFscywNCj4gc3RydWN0IGludGVyZmFjZSAqaW50ZXJmYWNlLA0KPiAgDQo+
ICAJcGFja2V0ID0gKHN0cnVjdCBhbGZyZWRfdGx2ICopYnVmOw0KPiAgDQo+ICsJbWVtc2V0KCZh
bGZyZWRfc291cmNlLCAwLCBzaXplb2YoYWxmcmVkX3NvdXJjZSkpOw0KPiAgCWlmIChnbG9iYWxz
LT5pcHY0bW9kZSkgew0KPiAgCQltZW1jcHkoJmFsZnJlZF9zb3VyY2UsICZzb3VyY2U0LnNpbl9h
ZGRyLA0KPiBzaXplb2Yoc291cmNlNC5zaW5fYWRkcikpOw0KPiAgCX0gZWxzZSB7DQo=
