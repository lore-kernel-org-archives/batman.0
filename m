Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2015 22:25:18 +0200
Message-ID: <1702615.bQe0nxSntn@bentobox>
In-Reply-To: <55C11772.90804@meshcoding.com>
References: <1438706134-3492-1-git-send-email-antonio@meshcoding.com>
 <20150804.124040.324026088945274161.davem@davemloft.net>
 <55C11772.90804@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1738294.tkllGgauPj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv 20150804
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1738294.tkllGgauPj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[moved this to a b.a.t.m.a.n only-discussion]

On Tuesday 04 August 2015 21:50:10 Antonio Quartulli wrote:
> 
> On 04/08/15 21:40, David Miller wrote:
> > From: Antonio Quartulli <antonio@meshcoding.com>
> > Date: Tue,  4 Aug 2015 18:35:20 +0200
> > 
> >> here you have our batch of fixes intended for net/linux-4.2.
> > 
> > Sorry, you can't come to me this late in the -RC series with such
> > a huge collection of bug fixes.
> > 
> > Break out the most important critical ones, and only submit those.
> > The rest will have to go via net-next.
> 
> Ok David, I will split it up.
> 
> Thanks for the quick feedback!


My vote for patches to send now:

1. batman-adv: avoid DAT to mess up LAN state
2. batman-adv: fix kernel crash due to missing NULL checks
3. batman-adv: protect tt_local_entry from concurrent delete events
4. batman-adv: initialize up/down values when adding a gateway

Kind regards,
	Sven
--nextPart1738294.tkllGgauPj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVwR+xAAoJEF2HCgfBJntGQ0cP/3fIzv1/Ztnl66wHzxW4gFim
tmWX+LXGx7DhZpGNJUakYkQAM2T8RETS0QIuF8mgDbFh/ABiHR01VcyLu3CfmDdx
nJYtPNehzQBZgnFNlvIACOi1XcePtyDiyfVtt98PEQh9qi3UyDjEHr3FDxq6xkLC
YLGgvbtgyFkqksv1kP8WnAkTvudgEy4h+nt62uIMR/pQ0EENumoQfjy47C3txlw3
LqPmh2AyieNxUKF5Yjtlmsg1EmZg2Mvm6jiOxVVnMK/3DyAaIkRfUIC/BJEgT4Kf
DjQHK8WBi5y7G3jnpu2jQ4tOI7XvBnUKXwN9UQwXhk27gRRORi80ouz7TLliqdrO
Stk9VW7eO+xYfeiHFRnG2/nPrmJyWYAKjkev5s8TLgO1v6SDVUL/EhCE3HxaN8fL
rp4lgbmLzpjD4Nv0PbSuje4IrSBrX8atlREpG3MeWNCW7r/U98ESgWmYbZg0mm2a
jZFpOkMtTqdE2i1T9fUoiR6KtywmbTvsXkgd9N8gTo1dGIDbJ20CktPZv4iLV0TY
C7Vjr5NsBFbdzi5kRi1c852e0evklIJIPTqT7JoS+dxj8HcbdlG55AYNG1ni4A/T
4JNDhjCFRXE+DAei0NkRG0dd2saaM+uy/sxhnjByBvAQFczVhr7T1CA9MZFWv3iw
zjoQ65Hlwh9nujEiV/BQ
=TfyB
-----END PGP SIGNATURE-----

--nextPart1738294.tkllGgauPj--

