Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Mon, 21 Dec 2009 15:00:03 +0100
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A22C241@RESQNAOEX01.qnao.net>
	<200912201601.05350.onelektra@gmx.net>
	<20091221092358.GF26298@alix.l28.local>
In-Reply-To: <20091221092358.GF26298@alix.l28.local>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200912211500.03724.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] wireless adapter and linux kernel version
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hello Bastian -

well, one might argue about that. The IBSSID is not a MAC address, IMHO. The 
IBSSID uses a EUI-48 identifier format. In master mode the BSSID is derived 
from the AP NICs MAC address. So if you override the factory MAC with a 
locally configured MAC of your APs NIC, you ought to use 02: rather than 00:, 
true.

However IBSSID's according to 802.11 protocol ought to be randomly generated - 
and most drivers do just that, regardless whether they begin with 02: or not. 
(I think the old Orinoco firmware did it that way, but I'm not sure)

So I think it is OK to use whatever you like and is easy to remember, except 
00:00:00:00:00:00 or FF:FF:FF:FF:FF:FF

> so use: 02:BE:EF:CA:FF:EE 8-)

Of course. 

The problem with the popular IBSSID 02:CA:FF:EE:BA:BE is that you get strange 
effects if you have two different ad-hoc cells in range, which are accidently 
using the same IBSSID...

Cheers,
Elektra

(cu @26c3:)

