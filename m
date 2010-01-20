Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 20 Jan 2010 17:42:50 +0800
References: <20100119145806.275330@gmx.net>
	<201001201015.59477.lindner_marek@yahoo.de>
	<20100120092904.181520@gmx.net>
In-Reply-To: <20100120092904.181520@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201001201742.50888.lindner_marek@yahoo.de>
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

On Wednesday 20 January 2010 17:29:04 Juha Yl=F6nen wrote:
> Could be the first one in the list as brctl fails. CONFIG_BRIDGE is not
>  configured in the device kernel. Is batman-adv dependent on this? I'll
>  recompile the kernel and see what happens (it's a slow process), in the
>  meanwhile, what other kernel configurations are needed for batman-adv?

No, it is not required but bridging is the best way to connect batman-adv w=
ith=20
non-mesh participants, therefore many people use bridging. It is easy to ad=
d=20
the wrong interface to the wrong bridge and then strange things happen whic=
h=20
is way it is on my checklist.  ;)

Regards,
Marek
