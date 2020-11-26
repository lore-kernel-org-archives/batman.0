Return-Path: <annika.wickert@exaring.de>
From: Annika Wickert <annika.wickert@exaring.de>
Subject: Re: [PATCH 1/2] vxlan: Add needed_headroom for lower device
Date: Thu, 26 Nov 2020 18:19:49 +0000
Message-ID: <8257B44A-FA67-40D1-BC5E-C8AB82E42BFE@exaring.de>
References: <20201126125247.1047977-1-sven@narfation.org>
In-Reply-To: <20201126125247.1047977-1-sven@narfation.org>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-ID: <F46B60D86DB16C4CBCE1B5368EAC7B67@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

VGVzdGVkLWJ5OiBBbm5pa2EgV2lja2VydCA8YXdAYXdsbnguc3BhY2U+DQogDQoNCu+7v09uIDI2
LjExLjIwLCAxMzo1MywgIlN2ZW4gRWNrZWxtYW5uIiA8c3ZlbkBuYXJmYXRpb24ub3JnPiB3cm90
ZToNCg0KICAgIEl0IHdhcyBvYnNlcnZlZCB0aGF0IHNlbmRpbmcgZGF0YSB2aWEgYmF0YWR2IG92
ZXIgdnhsYW4gKG9uIHRvcCBvZg0KICAgIHdpcmVndWFyZCkgcmVkdWNlZCB0aGUgcGVyZm9ybWFu
Y2UgbWFzc2l2ZWx5IGNvbXBhcmVkIHRvIHJhdyBldGhlcm5ldCBvcg0KICAgIGJhdGFkdiBvbiBy
YXcgZXRoZXJuZXQuIEEgY2hlY2sgb2YgcGVyZiBkYXRhIHNob3dlZCB0aGF0IHRoZQ0KICAgIHZ4
bGFuX2J1aWxkX3NrYiB3YXMgY2FsbGluZyBhbGwgdGhlIHRpbWUgcHNrYl9leHBhbmRfaGVhZCB0
byBhbGxvY2F0ZQ0KICAgIGVub3VnaCBoZWFkcm9vbSBmb3I6DQoNCiAgICAgIG1pbl9oZWFkcm9v
bSA9IExMX1JFU0VSVkVEX1NQQUNFKGRzdC0+ZGV2KSArIGRzdC0+aGVhZGVyX2xlbg0KICAgICAg
CQkrIFZYTEFOX0hMRU4gKyBpcGhkcl9sZW47DQoNCiAgICBCdXQgdGhlIHZ4bGFuX2NvbmZpZ19h
cHBseSBvbmx5IHJlcXVlc3RlZCBuZWVkZWQgaGVhZHJvb20gZm9yOg0KDQogICAgICBsb3dlcmRl
di0+aGFyZF9oZWFkZXJfbGVuICsgVlhMQU42X0hFQURST09NIG9yIFZYTEFOX0hFQURST09NDQoN
CiAgICBTbyBpdCBjb21wbGV0ZWx5IGlnbm9yZWQgdGhlIG5lZWRlZF9oZWFkcm9vbSBvZiB0aGUg
bG93ZXIgZGV2aWNlLiBUaGUgZmlyc3QNCiAgICBjYWxsZXIgb2YgbmV0X2Rldl94bWl0IGNvdWxk
IHRoZXJlZm9yZSBuZXZlciBtYWtlIHN1cmUgdGhhdCBlbm91Z2ggaGVhZHJvb20NCiAgICB3YXMg
YWxsb2NhdGVkIGZvciB0aGUgcmVzdCBvZiB0aGUgdHJhbnNtaXQgcGF0aC4NCg0KICAgIENjOiBB
bm5pa2EgV2lja2VydCA8YW5uaWthLndpY2tlcnRAZXhhcmluZy5kZT4NCiAgICBTaWduZWQtb2Zm
LWJ5OiBTdmVuIEVja2VsbWFubiA8c3ZlbkBuYXJmYXRpb24ub3JnPg0KICAgIC0tLQ0KICAgICBk
cml2ZXJzL25ldC92eGxhbi5jIHwgMSArDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Z4bGFuLmMgYi9kcml2ZXJzL25l
dC92eGxhbi5jDQogICAgaW5kZXggMjM2ZmNjNTVhNWZkLi4yNWI1YjVhMmRmZWEgMTAwNjQ0DQog
ICAgLS0tIGEvZHJpdmVycy9uZXQvdnhsYW4uYw0KICAgICsrKyBiL2RyaXZlcnMvbmV0L3Z4bGFu
LmMNCiAgICBAQCAtMzc5OSw2ICszNzk5LDcgQEAgc3RhdGljIHZvaWQgdnhsYW5fY29uZmlnX2Fw
cGx5KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQogICAgIAkJZGV2LT5nc29fbWF4X3NlZ3MgPSBs
b3dlcmRldi0+Z3NvX21heF9zZWdzOw0KDQogICAgIAkJbmVlZGVkX2hlYWRyb29tID0gbG93ZXJk
ZXYtPmhhcmRfaGVhZGVyX2xlbjsNCiAgICArCQluZWVkZWRfaGVhZHJvb20gKz0gbG93ZXJkZXYt
Pm5lZWRlZF9oZWFkcm9vbTsNCg0KICAgICAJCW1heF9tdHUgPSBsb3dlcmRldi0+bXR1IC0gKHVz
ZV9pcHY2ID8gVlhMQU42X0hFQURST09NIDoNCiAgICAgCQkJCQkgICBWWExBTl9IRUFEUk9PTSk7
DQogICAgLS0gDQogICAgMi4yOS4yDQoNCg0K
