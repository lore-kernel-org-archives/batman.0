Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 05:16:46 +0800
Message-ID: <1572215.6K5rTnkNup@voltaire>
In-Reply-To: <5732316F.7020209@tu-bs.de>
References: <5732316F.7020209@tu-bs.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16817679.qITfJV8zzW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Unable to ping interface in ap mode / client
	mode with IP4 addr
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart16817679.qITfJV8zzW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 10, 2016 21:07:27 Hannes Harms wrote:
> But I can not ping with an IP4 addr.
> 
> bat0 was added to a bridge interface with a static IP on both machines.
> No DHCP server is running, because only static IPS are needed.

Can you describe from where you are pinging (which hosts are involved) and 
post the IP configuration (e.g. ip addr && ip route) ?

Thanks,
Marek

--nextPart16817679.qITfJV8zzW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMk++AAoJEFNVTo/uthzAmMsIALEkLdSArd1IPmAnHhPD5w28
SLBCYB86D/jZsboqdt9R/JAUjp+sn4MLQOhaGOP/eQjozP8mRAU69KcR03/x3DAf
NT3b8k5x/R+N5tZBLzXfC1e/5MVHHlk5Nxpg9kbJEutqfnmC+IkoPltoyEwYgCwM
Ga53+IIBLS+2l/g1+WpHgSGzAzNB/9PdK8sZFIs9HfX5s7djftYC9+hfDRPCaMT6
hwsz1K0vAr6+PVjYtRDV8+glnKNB73vaPdAcNv05mokmpUchbiNJOOuUpj6kYMQG
MrYoP3aFgnFWRChxDmrJ2chMrZXM9i4WTfqDAcxs93gb9H8sAysKCxs2zI8uPPk=
=/Akn
-----END PGP SIGNATURE-----

--nextPart16817679.qITfJV8zzW--

