Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 10 Nov 2010 12:06:18 +0100
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
	<1289350093-5782-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1289350093-5782-2-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201011101206.18881.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Allow promiscuous
	reception of unicast packets
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Linus =?utf-8?q?L=C3=BCssing?= <linus.luessing@ascom.ch>

On Wednesday 10 November 2010 01:48:13 Linus L=C3=BCssing wrote:
> Firstly, a very mobile node moving towards the sender along the hop path
> benefits from this as for such a mobility pattern the reception probabili=
ty
> increases, no matter how slow the topology convergence speed is.

Would you mind explaining why you think it helps for mobile nodes in the=20
scenario you mention ?
If I understand it correctly it helps for data originating from a non-mobil=
e=20
node traveling towards the mobile node but this is less critical (assuming =
the=20
mobile node has a higher orig interval). For data originating at the mobile=
=20
node traveling towards the non-mobile node it will only help if both nodes =
are=20
single hop neighbors.

Regards,
Marek
