Return-Path: <ordex@autistici.org>
Date: Thu, 19 Apr 2012 16:09:56 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120419140955.GA2408@ritirata.org>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<20120418180837.GB6589@ZenIV.linux.org.uk>
	<20120419061026.GC8658@ritirata.org>
	<20120419134854.GA6871@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20120419134854.GA6871@ZenIV.linux.org.uk>
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-04-18
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
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 19, 2012 at 02:48:54 +0100, Al Viro wrote:
> On Thu, Apr 19, 2012 at 08:10:27AM +0200, Antonio Quartulli wrote:
>=20
> > Hello Al,
> >=20
> > and thank you very much for your patches.
> > Before committing them, do you mind if we reword the subject by substit=
uting
> > "batman" with "batman-adv"?
>=20
> No problem...
>=20
> > Moreover, patch 3/4, fixes the memcpy() casting too other than the endi=
aness
>=20
> 4/4, actually.
>=20
> > stuff. We would prefer to have two different patches for fixing those t=
wo
> > issues. What about splitting it and resending them?
>=20
> Can do; I've just grepped for memcpy() in there, to see if there are other
> places like that. =20

Thanks!

> Haven't found any, but
> 	* you do an awful lot of GFP_ATOMIC allocations and those can and
> do fail from time to time.  What's worse, you ignore some of those failur=
es -
> e.g. failing allocation in orig_hash_{add,del}_if() will be ignored by the
> caller.  I haven't looked into that code enough to tell if it could be
> exploited, but I really don't like the look of it...
> 	* orig_node_add_if() leaves junk in added array elements.  You do
> kmalloc() followed by memcpy(), but leave the last element uninitialized.
> May be safe if you assign it soon enough, but I'd suggest checking that.
> 	* orig_node_del_if() looks odd - it removes element #hard_iface->if_num
> and shifts all subsequent ones down; then it renumbers interfaces to match
> that.  So far, so good, and there's even a plausible comment about lockin=
g:
>         /* renumber remaining batman interfaces _inside_ of orig_hash_loc=
k */
> except that no such lock exists since commit d007260.  What protects us f=
rom
> the obvious race in there?


Thank you very much for your analysis. I really appreciated it!
I'm CCing our mailing list so that other people can comment on it.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPkByzAAoJEFMQTLzJFOZFeowIAL+mA/wEcfSVBsAszkpQXobd
y5+G1yMCV8DJ1ocarwXxc+ISivYrCzUpb95tTEmeC4rwooVWZ8fcpsZlTuemS9R/
cBM/dTGWEaEa6sxbMS4zyaiUcHztynSzv4mbDiclCE45xHMi50Z/b6cXAaSUgBpz
bJUd2ys/xEVlyOV/4Lf+V5qplgaXtquAGxf3IdD1GpuTgV9DKE2QCfb9Ygmjqz+9
IC7n3RYG/i/yZE18iF0NgF1gzerMKocv49ejGL06fVU3gCmxXXtBz+DF0SUdAaoK
4p0j57Csdx8R7xR+kJloIqobKo92etkYa70ZKIT7edzqm/u9Raw6DWX+4xxyjgg=
=A5Vw
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
