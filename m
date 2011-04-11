Return-Path: <ryan@iheartryan.com>
Date: Mon, 11 Apr 2011 11:35:29 -0400 (EDT)
From: Ryan Hughes <ryan@iheartryan.com>
Message-ID: <alpine.DEB.2.00.1104111123540.4431@minime>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-690419112-1302536130=:4431"
Subject: [B.A.T.M.A.N.] Gateway
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-690419112-1302536130=:4431
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Okay, so I'm putting aside my concerns about running batman side-by-side 
with something else.  The WBMv3 script looks like a pretty good guide to 
that.  I'm having more basic problems right now.

I don't seem to understand how to set up the gateway.

I'm using bmx6 right now (is that on-topic for this list?  I assume the 
same things apply to batmand).

I started the node that has the gateway (node1) with:
bmxd -g 5mbit/1024kbit dev=wlan0

and the one without the gateway (node2) with:
bmxd -r 3 dev=wlan0

node2 is aware of node1's gateway, as evidenced by bmxd -c -d 2:

   Originator         bestNextHop   #         preferred gateway: 0.0.0.0
=> 10.0.1.1               10.0.1.1  94, gw_class 49 - 4MBit/1024KBit, reliability: 0, supported tunnel types 2WT, 1WT

but I am unable to ping out to the internet from node2.

Is this a firewall problem?  What should I be doing differently with the 
firewall?  I think I have node1's firewall forwarding (and 
masquerading) from the tunnel interface to my lan interface (where the 
gateway is plugged in).  batmand documentation refers to the tunnel 
interface as gate0, but bmxd calls this interface bat0.

I attached my /etc/config/firewall.

Also, here is a little snippet from iftop -i bat0 run on node1 while node2 
was trying to ping 141.1.1.1.  It shows that the pings make it as far as 
node1, but don't make it out.  That's why I'm thinking firewall.

169.254.0.0                => 169.254.0.132               896b    896b    896b
                            <=                               0b      0b      0b
169.254.0.132              => cns1.cw.net                 672b    672b    672b
                            <=                               0b      0b      0b

Is there some other step I'm supposed to do?  bridging the tunnel 
interface with my lan interface?  (I doubt it).

Thanks.
--Ryan
--8323329-690419112-1302536130=:4431
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=firewall
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.1104111135290.4431@minime>
Content-Description: 
Content-Disposition: attachment; filename=firewall

Y29uZmlnIGRlZmF1bHRzDQoJb3B0aW9uIHN5bl9mbG9vZAkxDQoJb3B0aW9u
IGlucHV0CQlBQ0NFUFQNCglvcHRpb24gb3V0cHV0CQlBQ0NFUFQgDQoJb3B0
aW9uIGZvcndhcmQJCVJFSkVDVA0KIyBVbmNvbW1lbnQgdGhpcyBsaW5lIHRv
IGRpc2FibGUgaXB2NiBydWxlcw0KIwlvcHRpb24gZGlzYWJsZV9pcHY2CTEN
Cg0KY29uZmlnIHpvbmUNCglvcHRpb24gbmFtZQkJbGFuDQoJb3B0aW9uIGlu
cHV0CUFDQ0VQVCANCglvcHRpb24gb3V0cHV0CUFDQ0VQVCANCglvcHRpb24g
Zm9yd2FyZAlBQ0NFUFQNCglvcHRpb24gbWFzcQkxDQoJb3B0aW9uIG10dV9m
aXgJMQ0KCQ0KY29uZmlnIHpvbmUNCglvcHRpb24gbmFtZQkJJ21lc2gwJw0K
CW9wdGlvbiBpbnB1dAlBQ0NFUFQNCglvcHRpb24gb3V0cHV0CUFDQ0VQVA0K
CW9wdGlvbiBmb3J3YXJkICBBQ0NFUFQNCg0KY29uZmlnIGZvcndhcmRpbmcg
DQoJb3B0aW9uIHNyYyAgICAgIG1lc2gwDQoJb3B0aW9uIGRlc3QgICAgIGxh
bg0KCQ0KY29uZmlnIHpvbmUNCglvcHRpb24gbmFtZSAJJ2JhdDAnDQoJb3B0
aW9uIGlucHV0CUFDQ0VQVA0KCW9wdGlvbiBvdXRwdXQJQUNDRVBUDQoJb3B0
aW9uIGZvcndhcmQJQUNDRVBUDQoJDQpjb25maWcgZm9yd2FyZGluZw0KCW9w
dGlvbiBzcmMJYmF0MA0KCW9wdGlvbiBkZXN0CWxhbg0KCQ0KY29uZmlnIGZv
cndhcmRpbmcNCglvcHRpb24gc3JjCWxhbg0KCW9wdGlvbiBkZXN0CWJhdDAN
CgkNCiMgV2UgbmVlZCB0byBhY2NlcHQgdWRwIHBhY2tldHMgb24gcG9ydCA2
OCwNCiMgc2VlIGh0dHBzOi8vZGV2Lm9wZW53cnQub3JnL3RpY2tldC80MTA4
DQpjb25maWcgcnVsZQ0KCW9wdGlvbiBzcmMJCWxhbg0KCW9wdGlvbiBwcm90
bwkJdWRwDQoJb3B0aW9uIGRlc3RfcG9ydAk2OA0KCW9wdGlvbiB0YXJnZXQJ
CUFDQ0VQVA0KCW9wdGlvbiBmYW1pbHkJaXB2NA0KDQojQWxsb3cgcGluZw0K
Y29uZmlnIHJ1bGUNCglvcHRpb24gc3JjIGxhbg0KCW9wdGlvbiBwcm90byBp
Y21wDQoJb3B0aW9uIGljbXBfdHlwZSBlY2hvLXJlcXVlc3QNCglvcHRpb24g
dGFyZ2V0IEFDQ0VQVA0KDQojIGluY2x1ZGUgYSBmaWxlIHdpdGggdXNlcnMg
Y3VzdG9tIGlwdGFibGVzIHJ1bGVzDQpjb25maWcgaW5jbHVkZQ0KCW9wdGlv
biBwYXRoIC9ldGMvZmlyZXdhbGwudXNlcg0KDQoNCiMjIyBFWEFNUExFIENP
TkZJRyBTRUNUSU9OUw0KIyBkbyBub3QgYWxsb3cgYSBzcGVjaWZpYyBpcCB0
byBhY2Nlc3Mgd2FuDQojY29uZmlnIHJ1bGUNCiMJb3B0aW9uIHNyYwkJbGFu
DQojCW9wdGlvbiBzcmNfaXAJMTkyLjE2OC40NS4yDQojCW9wdGlvbiBkZXN0
CQl3YW4NCiMJb3B0aW9uIHByb3RvCXRjcA0KIwlvcHRpb24gdGFyZ2V0CVJF
SkVDVCANCg0KIyBibG9jayBhIHNwZWNpZmljIG1hYyBvbiB3YW4NCiNjb25m
aWcgcnVsZQ0KIwlvcHRpb24gZGVzdAkJd2FuDQojCW9wdGlvbiBzcmNfbWFj
CTAwOjExOjIyOjMzOjQ0OjY2DQojCW9wdGlvbiB0YXJnZXQJUkVKRUNUIA0K
DQojIGJsb2NrIGluY29taW5nIElDTVAgdHJhZmZpYyBvbiBhIHpvbmUNCiNj
b25maWcgcnVsZQ0KIwlvcHRpb24gc3JjCQlsYW4NCiMJb3B0aW9uIHByb3Rv
CUlDTVANCiMJb3B0aW9uIHRhcmdldAlEUk9QDQoNCiMgcG9ydCByZWRpcmVj
dCBwb3J0IGNvbWluZyBpbiBvbiB3YW4gdG8gbGFuDQojY29uZmlnIHJlZGly
ZWN0DQojCW9wdGlvbiBzcmMJCQl3YW4NCiMJb3B0aW9uIHNyY19kcG9ydAk4
MA0KIwlvcHRpb24gZGVzdAkJCWxhbg0KIwlvcHRpb24gZGVzdF9pcAkJMTky
LjE2OC4xNi4yMzUNCiMJb3B0aW9uIGRlc3RfcG9ydAk4MCANCiMJb3B0aW9u
IHByb3RvCQl0Y3ANCg0KDQojIyMgRlVMTCBDT05GSUcgU0VDVElPTlMNCiNj
b25maWcgcnVsZQ0KIwlvcHRpb24gc3JjCQlsYW4NCiMJb3B0aW9uIHNyY19p
cAkxOTIuMTY4LjQ1LjINCiMJb3B0aW9uIHNyY19tYWMJMDA6MTE6MjI6MzM6
NDQ6NTUNCiMJb3B0aW9uIHNyY19wb3J0CTgwDQojCW9wdGlvbiBkZXN0CQl3
YW4NCiMJb3B0aW9uIGRlc3RfaXAJMTk0LjI1LjIuMTI5DQojCW9wdGlvbiBk
ZXN0X3BvcnQJMTIwDQojCW9wdGlvbiBwcm90bwl0Y3ANCiMJb3B0aW9uIHRh
cmdldAlSRUpFQ1QgDQoNCiNjb25maWcgcmVkaXJlY3QNCiMJb3B0aW9uIHNy
YwkJbGFuDQojCW9wdGlvbiBzcmNfaXAJMTkyLjE2OC40NS4yDQojCW9wdGlv
biBzcmNfbWFjCTAwOjExOjIyOjMzOjQ0OjU1DQojCW9wdGlvbiBzcmNfcG9y
dAkJMTAyNA0KIwlvcHRpb24gc3JjX2Rwb3J0CTgwDQojCW9wdGlvbiBkZXN0
X2lwCTE5NC4yNS4yLjEyOQ0KIwlvcHRpb24gZGVzdF9wb3J0CTEyMA0KIwlv
cHRpb24gcHJvdG8JdGNwDQo=

--8323329-690419112-1302536130=:4431--
