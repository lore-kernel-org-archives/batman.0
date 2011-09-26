Return-Path: <pmazart@web.de>
Date: Mon, 26 Sep 2011 09:05:22 +0200
From: "P. Mazart" <pmazart@web.de>
Message-ID: <20110926070522.GB4125@PC3.lan>
References: <3131360.5iACvcvJX2@ostrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3131360.5iACvcvJX2@ostrea>
Sender: pmazart@web.de
Subject: Re: [B.A.T.M.A.N.] batman-adv: loop caused by tinc and wifi
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

Hi,

On Mo, 26.09.2011 02:15:46, Bjoern Franke wrote:
> ath1 (ad-hoc) as batman-adv-interfaces
> ath0 (ap), tap0, eth0.1 and bat0 as a bridge

> Most of the nodes are connected via tinc and the network runs fine. But i=
f two=20
> nodes which have a tinc connection also get a ath1-connection, the whole=
=20
> network crashes.

Did I get you right, that =C2=BBath1-connection=C2=AB refers to a second
connction of two tinc hosts over another interface?
In this case I suspect it=E2=80=99s a tinc matter,
and iptables could be a solution.
Is there anything in the tinc logs?
Maybe =E2=80=9Etwo=E2=80=9C hosts with the _same_ identity?

Regards
P.M.
