Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Tue, 24 Jan 2017 16:07:47 +0000
Message-ID: <1485274067.2398.50.camel@sdl.usu.edu>
References: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
 <4448368.uV4yijacOc@prime> <1485272731.2398.15.camel@sdl.usu.edu>
 <1595128.WQAW59UAnQ@prime>
In-Reply-To: <1595128.WQAW59UAnQ@prime>
Reply-To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDDB06795854C34C87C476FF85FA618C@sdl.usu.edu>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: IPv4 multicast distribution
 support.
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "sw@simonwunderlich.de" <sw@simonwunderlich.de>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

DQo+ID4gPiDCoCogSSBkbyBub3Qgd2FudCB0byBnaXZlIHN1cHBvcnQgZm9yIElQdjQtcmVsYXRl
ZCBxdWVzdGlvbnMgb2YNCj4gPiA+IHVzZXJzLg0KPiA+ID4gV291bGTCoA0KPiA+ID4geW91IGJl
IGF2YWlsYWJsZSB0byBtYWludGFpbiBhbmQgYW5zd2VyIHF1ZXN0aW9ucyByZWdhcmRpbmcgdGhl
DQo+ID4gPiBJUHY0DQo+ID4gPiBzdXBwb3J0Pw0KPiA+IEknZCBiZSBoYXBweSB0byBhbnN3ZXIg
cXVlc3Rpb25zLCBidXQgaXQgd291bGQgYmUgYmVzdCBpZiB0aG9zZQ0KPiA+IHF1ZXN0aW9ucyBh
cmUgZGlyZWN0ZWQgdG8gdGhlIGxpc3QgYW5kIG15IGFkZHJlc3MgaXMgaW4gdGhlIENDDQo+ID4g
ZmllbGQuDQo+ID4gwqBUaGF0IHdheSBJJ2xsIGRlZmluaXRlbHkgc2VlIGl0IGFuZCBjYW4gYW5z
d2VyLsKgwqBJZiBpdCBqdXN0IGdvZXMNCj4gPiB0bw0KPiA+IHRoZSBsaXN0IGluIGdlbmVyYWwg
SSdsbCB2ZXJ5IGxpa2VseSBtaXNzIHRoZSBtZXNzYWdlLsKgwqBJcyB0aGF0DQo+ID4gc29tZXRp
bmcgdGhhdCBjb3VsZCBiZSBhZGRlZCB0byB0aGUgV2lraT8NCj4gSG1tLCB5b3UgY2FuIGFkZCBh
bnl0aGluZyB5b3Ugd2FudCBpbiB0aGUgd2lraSwgYnV0IGl0J3MgdW5saWtlbHkNCj4gc29tZW9u
ZSB3aWxswqANCj4gcmVhZCBpdCBiZWZvcmUgYXNraW5nIGhlcmUgb24gdGhlIG1haWxpbmcgbGlz
dCwgYXQgbGVhc3QgdG8gbXkNCj4gcGVyc29uYWzCoA0KPiBleHBlcmllbmNlLiA7KQ0KPiANCj4g
QnV0IGlmIHlvdSBjb21taXQgdG8gbG9vayBpbnRvIHRoZXNlIGlzc3VlcywganVzdCB0cnkgdG8g
Y2F0Y2ggdGhlDQo+IG1haWxzIHNlbnTCoA0KPiBoZXJlIHRvIHRoaXMgbWFpbGluZyBsaXN0IC0g
aWYgeW91IGRvbid0IGknbGwgdHJ5IHRvIGZvcndhcmQgdGhlbSB0bw0KPiB5b3UuIDopDQoNCkkn
bGwgZG8gbXkgYmVzdCB0byBrZWVwIGFuIGV5ZSBvbiB0aGluZ3MuIMKgSWYgeW91IHNlZSBzb21l
dGhpbmcgYW5kIEkNCmRvbid0IHJlc3BvbmQsIEknZCBhcHByZWNpYXRlIHRoZSBmb3J3YXJkLg0K
DQo+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gwqAqIERvIHlvdSBwbGFuIHRvIHByb3ZpZGUg
T3BlbldSVCBzdXBwb3J0IGFzIHdlbGw/IChUaGlzIGlzIG1vcmUNCj4gPiA+IG91dA0KPiA+ID4g
b2bCoA0KPiA+ID4gY3VyaW9zaXR5KQ0KPiA+IEkgd2Fzbid0IHBsYW5uaW5nIG9uIE9wZW5XUlQg
c3VwcG9ydC4gV2hhdCB3b3VsZCBiZSBlbnRhaWxlZD8gV2hlbg0KPiA+IEkNCj4gPiBoZWFyIE9w
ZW5XUlQsIEkgdGhpbmsgb2YgdGhlIGZpcm13YXJlIEkgY2FuIGxvYWQgb250byBteSBvbGQNCj4g
PiBMaW5rc3lzDQo+ID4gV1JUNTRHIEFQLsKgwqBXb3VsZCBpdCBzaW1wbHkgYmUgdGVzdGluZyB0
aGVzZSBjaGFuZ2VzIG9uIHRoYXQNCj4gPiBkZXZpY2U/DQo+IEJhc2ljYWxseSB3ZSBhbHJlYWR5
IGhhdmUgYW4gT3BlbldSVC9MRURFIGludGVncmF0aW9uIFsxXSB3aGljaA0KPiBwcm92aWRlc8Kg
DQo+IGNvbmZpZ3VyYXRpb24gb3B0aW9ucyBpbiBhIGNvbmZpZyBmaWxlLCB3aGljaCBhcmUgcGFy
c2VkIGFuZCBhcHBsaWVkDQo+IGV0Yy4NCj4gDQo+IE5vdCBzdXJlIGlmIHRoZSBhbmNpZW50IFdS
VDU0RyBpcyBzdGlsbCBldmVuIHByb3Blcmx5IHN1cHBvcnRlZCwgYnV0DQo+IHRoZXJlIGFyZcKg
DQo+IGRvemVucyBvZiBjaGVhcCBhbmQgbW9yZSBtb2Rlcm5zIEFQcyB5b3UgY2FuIHVzZSBpdC4g
QnV0IGlmIHlvdSBhcmUNCj4gbm90wqANCj4gZmFtaWxpYXIgd2l0aCBPcGVuV1JULCBkb24ndCB3
b3JyeSwgc29tZW9uZSBlbHNlIGNhbiBwcm92aWRlIHRoZQ0KPiBpbnRlZ3JhdGlvbsKgDQo+IGlm
IHRoZXkgbmVlZCBpdC4gOikNCg0KSSB0aGluayB0aGF0IHNvdW5kcyBncmVhdC4gwqBUaGFua3Mh
