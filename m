Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sun, 17 Aug 2014 21:14:22 +0200
Message-ID: <2277980.eEMmOJuA1H@prime>
In-Reply-To: <1406675698-20416-2-git-send-email-linus.luessing@web.de>
References: <1406675698-20416-1-git-send-email-linus.luessing@web.de>
 <1406675698-20416-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batctl: adding mcast flags debugfs
	table
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Wednesday 30 July 2014 01:14:58 Linus L=C3=BCssing wrote:
[...]
> diff --git a/README b/README
> index c5e3575..08c8e98 100644
> --- a/README
> +++ b/README
> @@ -425,6 +425,40 @@ display or modify the multicast mode setting
>=20
>  Usage: batctl multicast_mode|mm [0|1]
>=20
> +batctl mcast_flags
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +display the local D.A.T. cache
> +
> +Usage batctl mcast_flags|mf
> +
> +Example:
> +
> +Multicast flags (own flags: [U..])
> +* Bridged [U]=09=09=09=09+
> +* No IGMP/MLD Querier [4/6]:=09=09-
> +* Shadowing IGMP/MLD Querier [4/6]:=09-

I guess that section in the README needs an update now? Linus, can you =
update=20
and resend please? Otherwise, these patches are fine.

Thanks!
    Simon
