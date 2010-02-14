Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 14 Feb 2010 17:58:24 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100214165824.GC25585@pandem0nium>
References: <20100208193848.GA8545@Sellars>
	<20100211022543.GA6493@Linus-Debian>
	<201002111720.16266.lindner_marek@yahoo.de>
	<201002121906.46804.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <201002121906.46804.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] race condition with activate_module?
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Works fine and really seems to make a difference when trying with the sslee=
p()
stuff from linus (which also crashes in my qemu testbed). After applying yo=
ur
patch it works fine. I have committed it along with some other sanity check=
s=20
in r1573.

On Fri, Feb 12, 2010 at 07:06:46PM +0800, Marek Lindner wrote:
> On Thursday 11 February 2010 17:20:16 Marek Lindner wrote:
> > Better than introducing some locking code which would need to halt the
> >  whole  module we should make sure that batman-adv does not process pac=
kets
> >  before its initialization is complete.
>=20
> I made a proof-of-concept patch (no testing yet) but it should illustrate=
 what=20
> I was talking about. Please try it.
>=20
> Cheers,
> Marek

> diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
> index 3f5744d..76dd4d2 100644
> --- a/batman-adv-kernelland/proc.c
> +++ b/batman-adv-kernelland/proc.c
> @@ -115,10 +115,6 @@ static ssize_t proc_interfaces_write(struct file *in=
stance,
> =20
>  	hardif_add_interface(if_string, if_num);
> =20
> -	if ((atomic_read(&module_state) =3D=3D MODULE_INACTIVE) &&
> -	    (hardif_get_active_if_num() > 0))
> -		activate_module();
> -
>  	rcu_read_lock();
>  	if (list_empty(&if_list)) {
>  		rcu_read_unlock();
> @@ -127,6 +123,11 @@ static ssize_t proc_interfaces_write(struct file *in=
stance,
>  	rcu_read_unlock();
> =20
>  	num_ifs =3D if_num + 1;
> +
> +	if ((atomic_read(&module_state) =3D=3D MODULE_INACTIVE) &&
> +	    (hardif_get_active_if_num() > 0))
> +		activate_module();
> +
>  	return count;
> =20
>  end:
> @@ -453,7 +454,7 @@ static ssize_t proc_aggr_write(struct file *file, con=
st char __user *buffer,
>  		       atomic_read(&aggregation_enabled),
>  		       (aggregation_enabled_tmp =3D=3D 1 ? "enabled" : "disabled"),
>  		       aggregation_enabled_tmp);
> -		atomic_set(&aggregation_enabled,=20
> +		atomic_set(&aggregation_enabled,
>  						(unsigned)aggregation_enabled_tmp);
>  	}
> =20


--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkt4K7AACgkQrzg/fFk7axYKugCgr3FnPv0cHJ/jkx8ezUCEBbcJ
YxcAn0GczlwH6VcNHbcTwLSWHDptsT48
=UjAX
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
