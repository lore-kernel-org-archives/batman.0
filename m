Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2015 18:17:56 +0200
Message-ID: <5450614.1BWUbN25GJ@sven-edge>
In-Reply-To: <56113660.8080506@heidler.eu>
References: <56113660.8080506@heidler.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26741936.3eiHxOyW5F";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Alfred update-command
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>, Dominik Heidler <dominik@heidler.eu>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart26741936.3eiHxOyW5F
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 04 October 2015 16:23:28 Dominik Heidler wrote:
> Hi,
> 
> I tried to use the alfred update-command but it seems that the
> update-command is only triggered when data is purged but not when new
> data is received.
> 
> The changed_data_type() method is only called from the purge_data() method.
[...]

Nope, see finish_alfred_push_data (when data was synced to a master node):

		/* check that data was changed */
		if (new_entry_created ||
		    dataset->data.header.length != data_len ||
		    memcmp(dataset->buf, data->data, data_len) != 0)
			changed_data_type(globals, data->header.type);

It is useless on slave instances because they only pull data when it is 
required. But better ask Anatoliy because he is creator of this feature and 
the only one I know who seems to use it.

Kind regards,
	Sven
--nextPart26741936.3eiHxOyW5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWEVE0AAoJEF2HCgfBJntG0LsP/RKeCjahfOtizk+/0m3zGhIX
zQ8dv1qozo8L5sDM5FtNFUCjdjWRw1Q4EqBVyAcnmr7rECdXwq0ducR0NcMLNJz2
vTtWd8G4R2u/n6hxlf1fm9qt18OzTGZWqWkwFzWnkr5Z4HRWgJDUXwfYp7K9tyBF
+9zJVaWKBeBBlVN6SjdaiMSYbfKYrNZMoL4eA/4ToBehgrNANCCtkw8LE9NypceF
q+ZJ7VNWAvvDhmgcyLgCCuN4jnJMgECnQ6GXR2GIzWb54yQkCDYMf5VR+r3ghDiH
81hCX+f/L1fjopfDnyVrdpA4CeiNnWf7JzxTHyYm7g+faiNt0EEsFPKqXfzOeaq/
2O4D7qNXnqc6KzlXmz1YijIQb19DCEff7pCrPfaZWoxDDWQMfJMXyDg12Tj8n/hz
i3ar+yYr5zFRhqrAYHb0FiU4BmqX5Clc60gqN9FiXNVVSvraDDzNpGFKuslBzVz4
zG+M/9VDtQH/wRuHS7xG3371AYc2dZwR+bE7obCfec7ulRWaPz5SehG/g3b38/4O
6/ri7sGzFKtyH/6bNVdPJfHnxFlk7rA2IczV95O54S0GbMvw9e+PfuhJDbRPjaji
7jWaYq/PJfKhickq4yiW0sln3hUWy2jqzJJt7c5ArIidkgY1c7F4yPHiYBT6MrLC
O1yHUvSWvX+06uNDSQRl
=ktl5
-----END PGP SIGNATURE-----

--nextPart26741936.3eiHxOyW5F--

