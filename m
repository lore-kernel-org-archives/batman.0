Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Oct 2010 14:53:51 +0200
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<1286685001-15227-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286685001-15227-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010101453.52594.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Make number of
	(re)broadcasts configurable via sysfs
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

On Sunday 10 October 2010 06:30:00 Linus L=C3=BCssing wrote:
> Depending on the scenario, people might want to adjust the number of
> (re)broadcast of data packets - usually higher values in sparse or lower
> values in dense networks.

Is there a good reason to change this value at runtime or would a define be=
=20
enough ? I just get scared when we add too many options that almost nobody=
=20
cares about.=20

In other words: What is the use case ? Can we handle it by some kind of aut=
o-
detection ?

Regards,
Marek
