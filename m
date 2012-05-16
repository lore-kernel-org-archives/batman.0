Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 May 2012 19:23:46 +0200
Message-ID: <6139703.c6HifSHJNs@sven-desktop.home.narfation.org>
In-Reply-To: <201205151754.59179.lindner_marek@yahoo.de>
References: <1336840447-6580-1-git-send-email-sven@narfation.org>
	<1336840447-6580-3-git-send-email-sven@narfation.org>
	<201205151754.59179.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4347331.s4IJTPP6i8";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/18] batman-adv: Prefix bat_sysfs local
	static functions with batadv_
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart4347331.s4IJTPP6i8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-15"

On Tuesday 15 May 2012 17:54:58 Marek Lindner wrote:
> On Sunday, May 13, 2012 00:33:52 Sven Eckelmann wrote:
> > All non-static symbols of batman-adv were prefixed with batadv_ to avoid
> > collisions with other symbols of the kernel. Other symbols of batman-adv
> > should use the same prefix to keep the naming scheme consistent.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > 
> >  bat_sysfs.c |  250
> > 
> > ++++++++++++++++++++++++++++++++--------------------------- 1 file
> > changed, 135 insertions(+), 115 deletions(-)
> 
> Applied in revision 98881e4.
> 
> Thanks,
> Marek

But you only committed it partially. There are parts missing


Just to show what is missing:

@@ -123,8 +123,9 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 
 
 #define BAT_ATTR_HIF_STORE_UINT(_name, _min, _max, _post_func)		\
-ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
-		      char *buff, size_t count)				\
+ssize_t batadv_store_##_name(struct kobject *kobj,			\
+			     struct attribute *attr, char *buff,	\
+			     size_t count)				\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct hard_iface *hard_iface;					\
@@ -142,8 +143,8 @@ ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
 }
 
 #define BAT_ATTR_HIF_SHOW_UINT(_name)					\
-ssize_t show_##_name(struct kobject *kobj,				\
-		     struct attribute *attr, char *buff)		\
+ssize_t batadv_show_##_name(struct kobject *kobj,			\
+			    struct attribute *attr, char *buff)		\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct hard_iface *hard_iface;					\

--nextPart4347331.s4IJTPP6i8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPs+KiAAoJEF2HCgfBJntGrKgQAIvn03IiJLO5Ut/R9pgLe5Hv
xOyu+JLI5MLgFI6O21G15GFQ3//oPyW3SOml1QIYfB2QEpJMT5/rYcSNt21kXRJE
oICxl26h4QpKcAyP3XsElNhaglOVuqS3V8IQnUK9/x1XXAdjLa1QDYcCA3AaEa+1
LzWZrGVzFPogBaX67ZYMk0dTuS6dttCcLVtxBeYOV+N3V8fkevf/0JiAhrSrIUps
pxkOeQkkNoFcru2t3PFD4YNaR3hzeCiM3NyWCPuoncuxqvyD6OA7YOkNz7dA6Joo
Lge7t+dlyzlQGQLVe53kw1vkoIWQVPkeBLtq8HCIiYE95nQGYVRKUrFPyJzSy1lQ
DIrTc52DZHkPSeTAdU8K7tongYter/FUMo1yqdxGGo1QRiIVEemUDMKWUn6a3qMQ
/VdAsu66T8AOPozNXIeHBJ1hrHprSsHvUaj6KYQt+5KczqYLDSG0SXyhUI1nX139
UykJjaplvTnMh3rRt4u1A3SOW9qNlcEl2hTh0qnxJXiyK+UpQF7EbHIdjxMbXuvQ
mZl9rmobENYXNHlFhgXItYE30X+xd7/etrUvQ1V+SVa8VEpqt6H9PonH5mTsvE5X
UChGNlkkCmezZ8/8tX/XMi/UmPo3GxPDkTWXCthvbLhK6cRtyWqJfdgFD3vVwMjj
d2Jwvs7OYsRJqhezg+t5
=NXtB
-----END PGP SIGNATURE-----

--nextPart4347331.s4IJTPP6i8--

