Return-Path: <liudows@aliyun.com>
Date: Thu, 07 Aug 2014 15:49:06 +0800
From: "liudows" <liudows@aliyun.com>
MIME-Version: 1.0
Message-ID: <53E32F6D.3010207@aliyun.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: [B.A.T.M.A.N.] how to make IP layer handle the change of network
	topology
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
To: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

SGVsbG8sIGV2ZXlvbmUsIEkgYW0gbGVhcm5pbmcgdGhlIGJhdG1hbi5hZHYgcmVjZW50bHkuICAg
DQoNCldlIGtub3cgdGhhdCBiYXRtYW4uYWR2IHdvcmtzIG9uIGxheWVyIDIuIFdoZW4gdGhlIG5l
dHdvcmsgdG9wb2xvZ3kgY2hhbmdlLCBiYXRtYW4uYWR2IGNhbiBrbm93IHRoaXMgY2hhbmdlIGFu
ZCBoYW5kbGUgaXQuIEJ1dCB0aGUgSVAgbGF5ZXIgZG9lc24ndCBrbm93IHRoYXQuIEhvdyB0byBt
YWtlIElQIGxheWVyIGhhbmRsZSB0aGUgY2hhbmdlIG9mIG5ldHdvcmsgdG9wb2xvZ3k/ICANCg0K
Rm9yIGV4YW1wbGUsIEkgaGF2ZSAzIG1lc2ggbm9kZXMsIGNsaWVudCBub2RlIEEsIGdhdGV3YXkg
bm9kZSBCIGFuZCBnZXRld2F5IG5vZGUgQy4gQSBjb25uZWN0cyAgdG8gaW50ZXJuZXQgdmlhIEIu
IFRoZW4gSSBzaHV0ZG93biBCLiBJIGd1ZXNzIEEgd2lsbCBzd2l0Y2ggdG8gQyBhcyBpdCdzIGdh
dGV3YXkgbm9kZSBhdXRvbWF0aWNhbGx5LiBCdXQgaXQncyBub3Qgc28uIEEgY29udGludW91c2x5
IHNlbmQgdGhlIEFSUCByZXF1ZXN0IHBhY2tldCB0byBzZWFyY2ggdGhlIE1BQyBhZGRyZXNzIG9m
IEIuIFRoZSBkZWZhdWx0IGdhdGV3YXkgaXMgc3RpbGwgQiwgbm90IEMuICANCg0KU28sIGhvdyBz
aG91bGQgSSBkbyB0byBtYWtlIHRoZSBJUCBsYXllciBiZSBhd2FyZSBvZiB0aGF0IHRoZSBnYXRl
d2F5IGhhcyBzd2l0aGVkIHRvIGFub3RoZXIgb25lPyAgDQoNClRoYW5rcyEgQmVzdCByZWdhcmRz
LiAgDQoNCmxpdSAg

