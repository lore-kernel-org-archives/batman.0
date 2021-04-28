Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batctl: Add JSON debug support
Date: Wed, 28 Apr 2021 12:45:23 +0200
Message-ID: <2557512.EezVJnfClc@sven-l14>
In-Reply-To: <20210428101608.3944861-1-asarmanow@gmail.com>
References: <20210428101608.3944861-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4940753.Nd4GfsuYql"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Alexander Sarmanow <asarmanow@gmail.com>

 
--nextPart4940753.Nd4GfsuYql
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>
Subject: Re: [PATCH] batctl: Add JSON debug support
Date: Wed, 28 Apr 2021 12:45:23 +0200
Message-ID: <2557512.EezVJnfClc@sven-l14>
In-Reply-To: <20210428101608.3944861-1-asarmanow@gmail.com>
References: <20210428101608.3944861-1-asarmanow@gmail.com>

On Wednesday, 28 April 2021 12:16:08 CEST Alexander Sarmanow wrote:
> A JSON output of the debug tables is still missing. Corresponding JSON
> output is added for originators, neighbors, translocal, transglobal and
> interfaces tables.

The interface list is not a debug table.

Btw. you print strings without making sure it doesn't break the json. There is 
something like this in alfred:

		for (i = 0; i < data_len; i++) {
			if (pos[i] == '"')
				printf("\\\"");
			else if (pos[i] == '\\')
				printf("\\\\");
			else if (!isprint(pos[i]))
				printf("\\x%02x", pos[i]);
			else
				printf("%c", pos[i]);
		}

> Same parameters of the debug tables can be used for
> the JSON, except the "-w [interval]" (not useful). The table header is
> implemented as a JSON equivalent and can be also optionally omitted.
> 

I would like to disagree. Why is it a problem to continuously emit json 
objects? 

> @@ -21,8 +22,12 @@ struct print_opts {
>         float watch_interval;
>         nl_recvmsg_msg_cb_t callback;
>         char *remaining_header;
> +       char *remaining_entry;
>         const char *static_header;
>         uint8_t nl_cmd;
> +       bool is_json;
> +       bool is_first;
> +       bool is_last;

Please don't use bools here. Change it to something more  like

    uint8_t is_json:1;
    uint8_t is_first:1;
    uint8_t is_last:1;


> +$(eval $(call add_command,originators_json,y))
> +$(eval $(call add_command,neighbors_json,y))
> +$(eval $(call add_command,translocal_json,y))
> +$(eval $(call add_command,transglobal_json,y))
> +$(eval $(call add_command,interfaces_json,y))

Please inserted it sorted.


> --- a/netlink.c
> +++ b/netlink.c
> @@ -318,15 +318,29 @@ static int info_callback(struct nl_msg *msg, void *arg)
>                 else
>                         extra_header = "";
>  
> -               ret = asprintf(&opts->remaining_header,
> -                              "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
> -                              version, primary_if,
> -                              primary_mac[0], primary_mac[1], primary_mac[2],
> -                              primary_mac[3], primary_mac[4], primary_mac[5],
> -                              mesh_name,
> -                              mesh_mac[0], mesh_mac[1], mesh_mac[2],
> -                              mesh_mac[3], mesh_mac[4], mesh_mac[5],
> -                              algo_name, extra_info, extra_header);
> +               if (opts->is_json) {
> +                       ret = asprintf(&opts->remaining_header,
> +                                      "{\"version\":\"%s\",\"main_if\":\"%s\",\"main_mac\":\"%02x:%02x:%02x:%02x:%02x:%02x\",\"mesh_if\":\"%s\",\"mesh_mac\":\"%02x:%02x:%02x:%02x:%02x:%02x\",\"algo_name\":\"%s\",\"extra_info\":\"%s\",\"data\":[",
> +                                      version, primary_if,
> +                                      primary_mac[0], primary_mac[1],
> +                                      primary_mac[2], primary_mac[3],
> +                                      primary_mac[4], primary_mac[5],
> +                                      mesh_name,
> +                                      mesh_mac[0], mesh_mac[1], mesh_mac[2],
> +                                      mesh_mac[3], mesh_mac[4], mesh_mac[5],
> +                                      algo_name, extra_info);
> +               } else {
> +                       ret = asprintf(&opts->remaining_header,
> +                                      "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
> +                                      version, primary_if,
> +                                      primary_mac[0], primary_mac[1],
> +                                      primary_mac[2], primary_mac[3],
> +                                      primary_mac[4], primary_mac[5],
> +                                      mesh_name,
> +                                      mesh_mac[0], mesh_mac[1], mesh_mac[2],
> +                                      mesh_mac[3], mesh_mac[4], mesh_mac[5],
> +                                      algo_name, extra_info, extra_header);
> +               }

Do we really have to add such kind of output to each table? Can't we just have 
another command to get the meshif info and print it?

Regarding the actual command code - why do we have to have manual print code? 
Can't we just define a structures how things should be printed and then have a 
semi-generic print function for netlink responses (which just needs the 
netlink to json definition)? This would also avoid this extremely ugly print 
which you have and avoids implementation errors for new tables.

There is most likely more stuff in there but I will stop the review for now.

Kind regards,
	Sven
--nextPart4940753.Nd4GfsuYql
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCJPMMACgkQXYcKB8Em
e0Z+WBAAnVf99LfxAlV0m8k0z9noDK/q4izMQXAO0mZpXxZCqAJ+R+XA9STJVuRW
wy13k3S8luay+AVG9kjJ/Rbq6QNZhLHf+qe4T6Gt4P881xJHjCkMnRWvo+VA2Jn8
4CLTVHhW7Cj/FYQxtvpcCB8PFvL52Do/IDfJBFkBmx1fM3AbmBd1s+QdTwssAHb6
RMUf4WRSWOoZgVWvJQ63w4ygm2Y6ygI8vtyj0bYsZ+7dD2ggEGNp4/8UQSVUk++9
DldYe7wQMrwuXQqblKam7TPhi3vTWbo0+0LJsDhwTflo/duAx+sDW2qzRq3UA8Hb
Wrc4CEM9drl+GP6FcWqMuh5PLw3EEcyGDd3SfHZBaXaMzdu0oXIU5Z5DILQCVhUA
nol1B5j3zchsaHtHeKMVqTRLRgOxsH+eataizGMd8LfwNlHm6tMYKSTofvvHh9CI
gKQXA2gLcxwqZdqy2KSkHaZrALuYA7W2hfiPX6BRo+8XnGLyP0gjCQEqYc6KA/XL
YpMIp5VIRdUHrjDGPAMAq4SM//hEio/GOOWiram5R32k3aMtpngNyKygiZ3KKqug
0pUuie3Hxz88LX+VVWXNcYcghGm2PF/1oSq1crHk5VGeKy4zV1Dx2/3jmWwpN19g
fX7VB73vBvt9dqDSQ8n8WFziZOczbpvoc/7ntufEu9OUEt+QOkQ=
=LPHu
-----END PGP SIGNATURE-----

--nextPart4940753.Nd4GfsuYql--


