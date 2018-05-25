Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 May 2018 13:15:42 +0200
Message-ID: <2273548.5hmqMeOsCk@bentobox>
In-Reply-To: <6fd70d33-11f7-33dd-3b11-e5031fe46466@cogentembedded.com>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
 <2946906.LStWHluSmG@bentobox>
 <6fd70d33-11f7-33dd-3b11-e5031fe46466@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5288828.giZyyWaQ0Y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Disable
 CONFIG_BATMAN_ADV_DEBUGFS by default
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Joe Perches <joe@perches.com>

--nextPart5288828.giZyyWaQ0Y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 25. Mai 2018 14:13:40 CEST Sergei Shtylyov wrote:
> > [...]
> >>> --- a/net/batman-adv/Kconfig
> >>> +++ b/net/batman-adv/Kconfig
> >>> @@ -94,13 +94,13 @@ config BATMAN_ADV_DEBUGFS
> >>> bool "batman-adv debugfs entries"
> >>> depends on BATMAN_ADV
> >>> depends on DEBUG_FS
> >>> -       default y
> >>> +       default n
> >>
> >> N is the default default. :-) You don't need this line.
> >
> > Hm, looks like this would have to be changed in a lot of places (~782
> > according to `git grep 'default n$'|wc -l` in my slightly outdated linux-
> > next). Do you want to fix it everywhere?
> 
>     No, but we can at least not add the new ones...

But the patch was added to net-next yesterday.

Kind regards,
	Sven
--nextPart5288828.giZyyWaQ0Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsH8F4ACgkQXYcKB8Em
e0aAdg//SAeoHLRG7E+oapwkClI3Db3mSWgue7UNZ4hJO8ynmIAJMZAEOGQa3RE2
t7jZOEhBJrLOKHSxtv+ltsWZ5zeicei8MmRSD701NjJpmxMlGm/6toHxM/YiTu5u
fiwCWv0zdBKiAjygysLdPvWIGSauNESWVUrO6j2zu66MqJk203Omx0deo7dC0M6c
ckCCCR9DsPRb3eCzY4RjE3bd76k3jDtB5NUHA7D6EbZFqMjvcOvESxqvWIO4jpBz
nFPp8hIUd72oT1wtPfFh1eY51PZhktlIFD/00lo9ZHyrfqEyFIZ8kNsLzsa0HJ0H
NhCS9kkonMoY98ogl/9/emWd2FjhM9jaQL20A9ngoiCwqDua/LnqwywqaVzZuEK4
wXDKIyLr+yL3pYUiVqKLUazar64d3EWLhwjnNY15VJGI9IixtoUwPpLGboItUPRM
I9I03rVeSoxo6Bwl4fTZy8/iGORuhIvE5xMxbc3QP84DDRzqW/oxi8oUOXA4hAVW
0tLPTIUa3s23u2evCBVM0xlyx33eQj3aIFW6NZ1SwJI2F8Ie5pt3dmr00Kt+S2+Q
BIIT+KUbe8daj/delLeIsLDDLhPUQ5mXy3pCLx9lmpLDEr5N8Jc1u/E6bkGr352u
Lx5P0lK7HuO24QcLGKooGdY8REQHGVnqqfgMtqCVM8r9P3F5Sc8=
=D669
-----END PGP SIGNATURE-----

--nextPart5288828.giZyyWaQ0Y--

