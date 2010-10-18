Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 18 Oct 2010 12:11:54 +0200
References: <201010151801.52611.lindner_marek@yahoo.de>
	<1287396119-7796-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1287396119-7796-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010181211.55541.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Adding sysfs API
	documentation for hop_penalty
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
Cc: Linus =?utf-8?q?L=C3=BCssing?= <linus.luessing@ascom.ch>

On Monday 18 October 2010 12:01:59 Linus L=C3=BCssing wrote:
> +               Defines the penalty which will be applied to an
> +               originator message's tq-field on every hop. In a
> +               mixed topology of static and mobile nodes, it might
> +               be desired to increase this value on the mobile ones
> +               instead of increasing the originator interval
> +               everywhere - or even set it to its maximum to disable
> +               forwarding on a node.

Sorry, but I don't quite understand the connection between hop penalty and=
=20
orig interval that you are trying to make here. The orig interval regulates=
=20
the interval in which the network is flooded with topology information wher=
eas=20
the hop penalty influences the likelihood of being chosen as a "hop" toward=
s a=20
destination.

Regards,
Marek
