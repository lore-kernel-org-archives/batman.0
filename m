Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Dec 2011 23:46:51 +0800
References: <1322835344-23077-1-git-send-email-martin@hundeboll.net>
	<201112031536.26477.lindner_marek@yahoo.de>
	<4EDA4332.6080706@hundeboll.net>
In-Reply-To: <4EDA4332.6080706@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201112032346.52327.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Move is_out_of_time() to
	main.c for general use
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

On Saturday, December 03, 2011 23:41:38 Martin Hundeb=C3=B8ll wrote:
> On 2011-12-03 08:36, Marek Lindner wrote:
> > Since it is a simple one-liner you could make it a define or at least
> > static inline (in main.h).
>=20
> Correct. Maybe the correct solution is to remove the function and just ca=
ll
> time_is_before_jiffies() directly instead?

Guess you misread me. I like the idea of having this easy to read wrapper.=
=20
Before you moved it to main.c it was a static function. The compiler could=
=20
better optimize it.

Cheers,
Marek
