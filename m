Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 12 Apr 2010 20:38:58 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100412183858.GA9739@pandem0nium>
References: <4BC2CB9E.4050309@aon.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <4BC2CB9E.4050309@aon.at>
Subject: Re: [B.A.T.M.A.N.] Patch batman-adv for kernel 2.6.15
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


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Franz,

the workqueues are the most "non-trivial" thing which prevented us so far
=66rom backporting batman-adv to these older kernel. I'd also be interested=
=20
to integrate patches if anyone has a solution for this. :)

best regards,
	Simon


On Mon, Apr 12, 2010 at 09:28:30AM +0200, Franz B=C3=B6hm wrote:
> Hi,
>
> I am trying to get batman-adv (kernelland) running on Ubiquiti Networks =
=20
> hardware. Unfortunately the Ubiquiti SDK uses kernel 2.6.15 and =20
> batman-adv needs at least 2.6.20. I did have some success in patching =20
> and running batman-adv-kernelland 0.1 (r1176). I would of course prefer =
=20
> using batman-adv 0.2 but I do have problems implementing the older =20
> kernel workqueue API.
>
> Perhaps someone can give me a hint on porting for example this function =
=20
> from send.c to the old workqueue API.
>
> void send_outstanding_bat_packet(struct work_struct *work)
> {
>    struct delayed_work *delayed_work =3D
>        container_of(work, struct delayed_work, work);
>    struct forw_packet *forw_packet =3D
>        container_of(delayed_work, struct forw_packet, delayed_work);
>    unsigned long flags;
>
>    spin_lock_irqsave(&forw_bat_list_lock, flags);
>    hlist_del(&forw_packet->list);
>    spin_unlock_irqrestore(&forw_bat_list_lock, flags);
>
>    send_packet(forw_packet);
>
>    /**
>     * we have to have at least one packet in the queue
>     * to determine the queues wake up time unless we are
>     * shutting down
>     */
>    if ((forw_packet->own) &&
>        (atomic_read(&module_state) !=3D MODULE_DEACTIVATING))
>        schedule_own_packet(forw_packet->if_incoming);
>
>    forw_packet_free(forw_packet);
> }
>
> Kind regards,
> Franz
>

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvDaMIACgkQrzg/fFk7axZc0QCgjAi3x1qwO7VCRAUxeX3KYhNL
KA4AoKBAVSt7dUo7u1+p4lIx8AaRt2qZ
=MG76
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
