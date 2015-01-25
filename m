Return-Path: <ff@jluehr.de>
Message-ID: <54C4EE81.1050902@jluehr.de>
Date: Sun, 25 Jan 2015 14:24:17 +0100
From: =?ISO-8859-15?Q?Jan_L=FChr?= <ff@jluehr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Understanding MAC-Adresses in iptables-Logs
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

Hello folks,

there appears to be some misconfiguration in our network. A gateway is
blocking unknown ip-addresses:

[658047.514011] FORWARD DROPPEDIN=bat0 OUT=backbone
MAC=3a:81:5b:64:fa:32:08:fc:88:9b:8a:60:08:00:45:00:00:4f:6c:b1:40:00:3f:06:b8:8e:0a:a6
SRC=10.166.28.69 DST=173.194.65.188 LEN=79 TOS=0x00 PREC=0x00 TTL=63
ID=27825 DF PROTO=TCP SPT=45173 DPT=5228 WINDOW=9131 RES=0x00 ACK PSH
URGP=0
[658047.519455] FORWARD DROPPEDIN=bat0 OUT=backbone
MAC=3a:81:5b:64:fa:32:08:fc:88:9b:8a:60:08:00:45:00:00:34:6c:b2:40:00:3f:06:b8:a8:0a:a6
SRC=10.166.28.69 DST=173.194.65.188 LEN=52 TOS=0x00 PREC=0x00 TTL=63
ID=27826 DF PROTO=TCP SPT=45173 DPT=5228 WINDOW=9131 RES=0x00 ACK FIN
URGP=0

I'm somewhat confused by the mac-address here - it's very long.
Can I somehow derive, which originator or client is propagating or using
this address?

Greetz, Jan
