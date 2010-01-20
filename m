Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 20 Jan 2010 10:15:59 +0800
References: <20100119145806.275330@gmx.net>
In-Reply-To: <20100119145806.275330@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201001201015.59477.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday 19 January 2010 22:58:06 Juha Yl=F6nen wrote:
> And a new try to send the log, previous was rather big and didn't get sen=
t.
>  This one is shorter and missing all the multicast traffic.

This log only contains packets from the Intel notebook. It seems the messag=
es=20
from the ARM device never leave the wifi card.

Before we dive into debugging the code I'd suggest you send us your complet=
e=20
interface configuration. Maybe the problem is much more simple than it seem=
s.=20
Complete configuration means: brctl show, ifconfig, cat /proc/net/batman-
adv/interfaces (or batctl if) and ping output.=20

Regards,
Marek
