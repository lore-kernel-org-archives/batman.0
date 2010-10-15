Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 15 Oct 2010 18:01:52 +0200
References: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
	<1286969589-31373-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1286969589-31373-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010151801.52611.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/4] batman-adv: Make hop_penalty
	configurable via sysfs
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

On Wednesday 13 October 2010 13:33:09 Linus L=C3=BCssing wrote:
> Exposing the hop_penalty is especially useful for the stated scenario: A
> static node can keep the default originator interval, a mobile node can
> select a quicker one resulting in faster route updates towards this
> mobile node. Additionally, such a mobile node could select a higher hop
> penalty (or even set it to 255 to disable acting as a router for other
> nodes) to make it less desirable, letting other nodes avoid selecting
> this mobile node as a router.

Could you please complete this patch by providing the proper sysfs API=20
documentation. For a reference simply check the sysfs-class-net-mesh file w=
hich=20
is now part of the repository.=20

Thanks,
Marek
