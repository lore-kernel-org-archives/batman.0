Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Mar 2011 03:01:13 +0100
References: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
	<1299086321-25116-9-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1299086321-25116-9-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201103030301.13786.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 08/12] batman-adv: Add sysfs option for
	enabling redundant bonding mode
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

On Wednesday 02 March 2011 18:18:37 Linus L=C3=BCssing wrote:
> When bonding is enabled, then enabling red_bonding too changes the
> behavior from throughput bonding (round robin sending on interfaces) to
> redundant bonding (sending every packet on all interfaces available for
> bonding).

Why not making redundant bonding a sysfs variant of bonding ? You wrote=20
yourself: "Also make sure to activate general bonding for redundant bonding=
 to=20
take effect". Having an extra option does not seem to make much sense ?!

Cheers,
Marek
