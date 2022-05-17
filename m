Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH v2] alfred: notify event listener via unix socket
Date: Tue, 17 May 2022 09:44:07 +0200
Message-ID: <10034333.HCmk49s6kI@rousseau>
In-Reply-To: <1727325.kRQH6uYu6r@sven-desktop>
References: <20220502114651.771309-1-mareklindner@neomailbox.ch>
 <1727325.kRQH6uYu6r@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6068079.UanAL4W2Ky";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

 
--nextPart6068079.UanAL4W2Ky
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2] alfred: notify event listener via unix socket
Date: Tue, 17 May 2022 09:44:07 +0200
Message-ID: <10034333.HCmk49s6kI@rousseau>
In-Reply-To: <1727325.kRQH6uYu6r@sven-desktop>
References: <20220502114651.771309-1-mareklindner@neomailbox.ch> <1727325.kRQH6uYu6r@sven-desktop>

Hi,

On Saturday, 14 May 2022 11:51:38 CEST Sven Eckelmann wrote:
> This version cannot be applied on top of the current master. I have attached
> the diff for the things which (afaik) need to be changed when you rebase
> the patch.
> 
> I have also attached the change to support the reporting of the source mac
> for the changed dataset.

I like the epoll change (to avoid unnecessary clutter) and also the source MAC 
reporting. For debugging purposes it might be useful to know where the change 
came from.

Thanks for preparing the rebase & code change patches. Wouldn't you say that 
EPOLL_CTL_DEL somewhere near unix_sock_event_listener_free() could be helpful?

Something like:
-static void unix_sock_event_listener_free(struct event_listener *listener)
+static void unix_sock_event_listener_free(struct globals *globals,
+                                         struct event_listener *listener)
 {
        list_del(&listener->list);
+       epoll_ctl(globals->epollfd, EPOLL_CTL_DEL, listener->fd, NULL);
        close(listener->fd);
        free(listener);
 }

Kind regards,
Marek Lindner

--nextPart6068079.UanAL4W2Ky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmKDUkcACgkQU1VOj+62
HMA06Qf/eBSCN2ELpUFBphUDZbOzYX6P7X6tVFMEqGYqkJxaEHBWf8sndUUodqsg
x4mUCN2ImDHmWkhBLRhiuk9m4/2F4nIymK6GdacUC0ivz/BkPmsb0m63bDM00oyN
D1EwIjaKIHB83zk3MM901IJH4JhaB2umMbWsq7e8t3fTWlid4shRSdTOTT11kZUj
mo3nRvA6U+FbM9yj8VVf5e7DBIOnFmP6eEoHlm0Rl1nkRl19Wn/zQyqNkvGgthCR
hQUkZj/f12TTiZhMcWkIoxmJPLE1kzgiOZvC8uz/0Rnbsp19TiWG95HE7y55UX5W
Yuhd/PDohx/Tba2SsW78dsy2VGpW/g==
=K/zn
-----END PGP SIGNATURE-----

--nextPart6068079.UanAL4W2Ky--



