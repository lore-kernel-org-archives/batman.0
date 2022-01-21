Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 3/3] alfred: properly initialize stack buffer before
 sending over unix socket
Date: Fri, 21 Jan 2022 16:34:50 +0100
Message-ID: <2782676.din1RKh0Nb@sven-l14>
In-Reply-To: <20220112210506.3488775-3-mareklindner@neomailbox.ch>
References: <10410848.OOsao9LFFs@rousseau>
 <20220112210506.3488775-1-mareklindner@neomailbox.ch>
 <20220112210506.3488775-3-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart68452153.uK6Os5FGOv";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart68452153.uK6Os5FGOv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 3/3] alfred: properly initialize stack buffer before sending over unix socket
Date: Fri, 21 Jan 2022 16:34:50 +0100
Message-ID: <2782676.din1RKh0Nb@sven-l14>
In-Reply-To: <20220112210506.3488775-3-mareklindner@neomailbox.ch>
References: <10410848.OOsao9LFFs@rousseau> <20220112210506.3488775-1-mareklindner@neomailbox.ch> <20220112210506.3488775-3-mareklindner@neomailbox.ch>

On Wednesday, 12 January 2022 22:05:06 CET Marek Lindner wrote:
[...]
> diff --git a/client.c b/client.c
> index b5d8943..cf15ff4 100644
> --- a/client.c
> +++ b/client.c
> @@ -35,6 +35,7 @@ int alfred_client_request_data(struct globals *globals)
>  		return -1;
>  
>  	len = sizeof(request);
> +	memset(&request, 0, len);
>  
>  	request.header.type = ALFRED_REQUEST;
>  	request.header.version = ALFRED_VERSION;

All bytes (also all bits) are overwritten in the lines below the memset. So I 
don't see why memset would be required here.

> @@ -184,6 +185,7 @@ int alfred_client_modeswitch(struct globals *globals)
>  		return -1;
>  
>  	len = sizeof(modeswitch);
> +	memset(&modeswitch, 0, len);
>  
>  	modeswitch.header.type = ALFRED_MODESWITCH;
>  	modeswitch.header.version = ALFRED_VERSION;

Same here - with a minor exception. When mode is not written then the data is 
not written to the socket.

> @@ -260,6 +262,7 @@ int alfred_client_change_interface(struct globals *globals)
>  	}
>  
>  	len = sizeof(change_interface);
> +	memset(&change_interface, 0, len);
>  
>  	change_interface.header.type = ALFRED_CHANGE_INTERFACE;
>  	change_interface.header.version = ALFRED_VERSION;\

Same here.

> @@ -308,6 +311,7 @@ int alfred_client_change_bat_iface(struct globals *globals)
>  	}
>  
>  	len = sizeof(change_bat_iface);
> +	memset(&change_bat_iface, 0, len);
>  
>  	change_bat_iface.header.type = ALFRED_CHANGE_BAT_IFACE;
>  	change_bat_iface.header.version = ALFRED_VERSION;
> 

Same here.

Kind regards,
	Sven


--nextPart68452153.uK6Os5FGOv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHq0poACgkQXYcKB8Em
e0a5Xw/+OVjV5ooaVxh8drOTTg38Uiz6psm8oIvQT+KNQuB3bZP7HapYih4dmxRw
a0iln9o6cK6MTkDOyIcy+PrANjA5MXMMdqjewc0ZUsYFq53t9THipHXuPzRwiixM
wTQWDDlsqwyRe3/2Xww3gAP2mX0//FpvOK0i/edtFgGh2mZEqtRRYL7vETpoW834
xbuVikOM/y7nISgykxN097wAWHS8jX0H9grpMyRrVJTXnMvzY4j8KL9VdyRKH/Cq
Q4iz33MaTGl6OqEqCwGV/VLIxQqkjuL/uklDCLePCeEBawNjiQPRqS+nSS5QPyKC
4PFBvrtmTIDPzEMzHDvRTu5m6qBSfJr3IsrDLzL09HIhVMMx4xEDRYDUW/eZRGOl
uDrUGpgxuLYDl0cX/lkCIaI0j0PRTg6vdr/lP+W2ODuSIALIDZowgg5/NLgdQ9kB
6LvlKeCGpNfrhTrPrvX2gMo/i4B5jxbwtAoqN/eTcGq/HPHwUSpKovh8OhY4WSmK
6YzxLZLt8ZKEC3+ZRz6p8MqZbQtg51YBGCQFuENj/qe63NK9J4rjdijxCPnu+wSi
GzjRwXim5r2si9deKfEAnLmFfTcsaGZ/QEIWJwRwRrKzXILAveYn7C/5SO4apg+8
IWd00wuC930b4Zlfqx0Ul2zJvqTpH8Vp2ZUUAlFRsaBLhWfGrUk=
=NkAU
-----END PGP SIGNATURE-----

--nextPart68452153.uK6Os5FGOv--


