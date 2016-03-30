Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 30 Mar 2016 10:15:30 +0800
Message-ID: <2039668.yJixVeb7rD@voltaire>
In-Reply-To: <56FB11B7.10103@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <4605306.DPF6tJRphQ@sven-edge>
 <56FB11B7.10103@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3677363.rW34EUV9Ub";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

--nextPart3677363.rW34EUV9Ub
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, March 30, 2016 01:37:27 Roland Volkmann wrote:
> Let's have a look to the source code. The interesting part is function 
> "static void batadv_send_outstanding_bcast_packet(struct work_struct 
> *work)" in file "send.c". There you will find
> 
>      soft_iface = forw_packet->if_incoming->soft_iface;
> [...]
>      /* rebroadcast packet */
>      rcu_read_lock();
>      list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
>          if (hard_iface->soft_iface != soft_iface)   /* !!! */
>              continue;
> 
>          if (forw_packet->num_packets >= hard_iface->num_bcasts)
>              continue;
> 
> The if-Statement marked with /* !!! */ results in "true", if 
> incoming-interface isn't identical to outgoing-interface. Because the 
> patch is included after this line, it is relevant for resending 
> broadcasts to the incoming interface only.

There seems to be a misunderstanding. With soft-interfaces batman-adv refers 
to the logic interface created for each mesh (often: bat0, bat1, etc). 
Consequently, the '!!!' marked if statement checks whether or not a given 
hard-interface (read: wlan0, eth0, etc) belongs to the same soft-interface the 
to be forwarded packet belongs to.

Hope that helps!

Cheers,
Marek

--nextPart3677363.rW34EUV9Ub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+zbCAAoJEFNVTo/uthzAsTUH/2HLo0mgFJqUdB5j7AZNNzGA
MNzfT0B+jJY3Zs3uxVm+ai7UQZJAV3bByPGdOQog4LY2TGHHlTmrQHdkd6blajPm
bUBPvIu99eJUyE36+Z0N8+rVrBZdW1Cry53CxOY2QuinigmCq1GhMfE1tgFj6RaN
djxO464FsqMz+fXuRAdjOji5gZ7fbqG7TmoGOH2ZnayitvlsrYRIV+O4v5gbZeTt
4VvOxrsq7/TxlaedXsxAj4fFLEvWjFh4drO3jEFfStCVRC0P08yAyaBHCQs3gkcB
00x4oRZhNTRXF+IqC0VIVYVf7qZ2KwpQhiYWTmF+cYRkbwfoQ/BF0mnqTATAbfU=
=lODR
-----END PGP SIGNATURE-----

--nextPart3677363.rW34EUV9Ub--

