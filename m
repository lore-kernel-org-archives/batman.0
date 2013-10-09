Return-Path: <David.Laight@ACULAB.COM>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 9 Oct 2013 16:49:53 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7385@saturn3.aculab.com>
In-Reply-To: <20131009143500.GH3544@neomailbox.net>
References: <1381322418-1349-1-git-send-email-antonio@meshcoding.com>
 <1381322418-1349-11-git-send-email-antonio@meshcoding.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7384@saturn3.aculab.com>
 <20131009143500.GH3544@neomailbox.net>
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

PiA+IEFyZSB5b3UgcmVhbGx5IGdlbmVyYXRpbmcgQ1JDMzIgb2YgYSBwaWxlIG9mIGV0aGVybmV0
IE1BQyBhZGRyZXNzZXMNCj4gPiBhbmQgdGhlIFhPUmluZyB0aGUgQ1JDIHRvZ2V0aGVyPw0KPiA+
IFRoYXQgZ2l2ZXMgdGhlIHNhbWUgYW5zd2VyIGFzIFhPUmluZyB0b2dldGhlciB0aGUgTUFDIGFk
ZHJlc3NlcyBhbmQNCj4gPiB0aGVuIGRvaW5nIGEgQ1JDIG9mIHRoZSBmaW5hbCB2YWx1ZS4NCj4g
DQo+IEkgd2FzIG5vdCBzdXJlIGFib3V0IHRoaXMgc2luY2UgdGhlIENSQzMyIGlzIG5vdCBhIGxp
bmVhciBvcGVyYXRpb24uIEhvd2V2ZXINCj4gdGhpcyByb3V0aW5lIGlzIG5vdCBvbiB0aGUgZmFz
dCBwYXRoLCBzbyB3ZSBjYW4gYWxzbyBsaXZlIHdpdGggdGhpcyBvcmRlci4NCg0KQWxsIENSQyBh
cmUgbGluZWFyLg0KQmVjYXVzZSAnKGEgKyBiKSBtb2QgYycgaXMgdGhlIHNhbWUgYXMgJygoYSBt
b2QgYykgKyAoYiBtb2QgYykpIG1vZCBjJy4NCg0KVGhlIENSQyBvZiBhIGJ1ZmZlciBpcyB0aGUg
WE9SIG9mIHRoZSBDUkNzIGdlbmVyYXRlZCBmb3IgZWFjaCAnMScgYml0Lg0KVGhlIENSQyBmb3Ig
ZWFjaCBiaXQgZGVwZW5kcyBvbiBob3cgZmFyIGl0IGlzIGZyb20gdGhlIGVuZCBvZiB0aGUgYnVm
ZmVyLg0KUHJlc2V0dGluZyB0aGUgQ1JDIHRvIGFsbC1vbmVzIGdlbmVyYXRlcyBhIHZhbHVlIHRo
YXQgaXMgZGVwZW5kZW50IG9uDQp0aGUgbGVuZ3RoIG9mIHRoZSBidWZmZXIgLSBvdGhlcndpc2Ug
bWlzc2luZy9leHRyYSBsZWFkaW5nIHplcm9zIGFyZQ0Kbm90IGRldGVjdGVkLg0KDQoJRGF2aWQN
Cg==
