Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 May 2016 18:41:07 +0200
Message-ID: <7072548.QEKymdYiIU@sven-edge>
In-Reply-To: <1463414932-1152-6-git-send-email-andrew@lunn.ch>
References: <1463414932-1152-1-git-send-email-andrew@lunn.ch>
 <1463414932-1152-6-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart60978604.1Rc7Krfb9a";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 05/11] batman-adv: netlink: add
	translation table query
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

--nextPart60978604.1Rc7Krfb9a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 16 May 2016 18:08:46 Andrew Lunn wrote:
> @@ -69,6 +123,8 @@ enum batadv_nl_commands {
>         BATADV_CMD_GET_MESH_INFO,
>         BATADV_CMD_GET_ROUTING_ALGOS,
>         BATADV_CMD_GET_HARDIFS,
> +       BATADV_CMD_GET_TRANSTABLE_LOCAL,
> +       BATADV_CMD_GET_TRANSTABLE_GLOBAL,
>         /* add new commands above here */
>         __BATADV_CMD_AFTER_LAST,
>         BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1

Kerneldoc missing. The TODO line was just removed from the patch but no line 
describing the cmd was added.


Kind regards,
	Sven
--nextPart60978604.1Rc7Krfb9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOfgjAAoJEF2HCgfBJntGeyUQANDFJKnFyYzCQpxjoxg7TDuQ
GmUI05yeOU7wMiD5cNtzEJ6jg9EsW8uTbqPl/eFXssraWcJu+VLb7H5J4Ch4InnQ
Z+hM8JawVDHVXKZoxf9FGN7Nhb36YVaXH1LIF77bGC3cl5//aQ4VqENxBASFK9Zd
IX6LM5qxzwK46LZCw7XMBw63+i+SsCvw9SUr3P9cDyDfFd0+bgyWXSY2IWf5GJaC
BnfC4ySfCPQ4AyIX1tdJyFrmAICcaxXF0SnjyE/uX3REEJ20ReDf46+BcPRnX6RL
b78kTdkb6cVKTCazHkSjGyx0YC2JOmuGdk3tP1HYBUfku3pvFLxXnSWko4g+W0v0
zjMx7K/hclFaHnPzC9m48zD+hw4xIApShH/RvOAJCRVAjYQ8/wQEmz/Mg3wzNMSj
l2Ui1DVtUI8r3vo6NxMYyBooLV5/ertBFe8NBA7Y9IRozEqLN3nwfvqRqbc0uhvG
keUmXQuXt3/0MEMxqWrOBcYciB2Z3dQ8BdOzIwqcSRlFXCymUuP+vOhUf60xeswV
KPu3Y81YD/1SzhnEMGBubhU3n/xnLn6WeYttUo1LG94MVlbWakXGGD0eVW/+J+iQ
O2iFGKl2hKkVtXMrPg0pOS9QU7XaYEq6e9oOpJlkKqoNRdo8NhxUOsEwxg4e0KU9
YVq6hD+6gFvF1zGd8UND
=k7Nc
-----END PGP SIGNATURE-----

--nextPart60978604.1Rc7Krfb9a--

