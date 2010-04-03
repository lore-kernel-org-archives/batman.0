Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 4 Apr 2010 00:29:24 +0200
References: <4BB70C4B.5000909@nord-west.org> <4BB73808.8080105@nord-west.org>
	<201004031841.46758.sven.eckelmann@gmx.de>
In-Reply-To: <201004031841.46758.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3043697.Vtg8E1HyIM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004040029.26465.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] running batman-adv in a openvz VE
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

--nextPart3043697.Vtg8E1HyIM
Content-Type: multipart/mixed;
  boundary="Boundary-01=_FF8tLrxyhc7kpQM"
Content-Transfer-Encoding: 7bit


--Boundary-01=_FF8tLrxyhc7kpQM
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sven Eckelmann wrote:
> > OpenVZ-Containers use the same kernel as the host system and I can build
> > and load the module on the host, but I don't know how to access
> > /proc/net/batman-adv from within the container. The container uses a own
> > proc-fs.
>=20
> Ok, that is correct. I wanted to check how to work around such problems a=
nd
> how to implement it in the new configuration api/multiple bat-device
> implementation for 0.3 (or later) - but unfortunately  OpenVZ for 2.6.32
>  was only good to crash my system very hard. (but it is at least a known
>  upstream bug :) )
> So it can take a little bit longer until I really checked what we can do
>  here.

Just to document some stuff I ran into:

Ok, was a little bit work to get 2.6.32 working with openvz and without the=
se=20
nasty vfs crashes, but now it boots up correctly.  The first thing I checke=
d=20
was if it is possible to create bridge devices in VEs - and the result was=
=20
quite impressive. It can create a socket to create the bridge, but the ioct=
l=20
fails. The problem seems to be the get_exec_env()->features doesn't have=20
VE_FEATURE_BRIDGE set (ENOTTY).

vzctl set 777 --features "bridges:on" --save

should fix it - but is not supported by the current vzctl. But even after=20
using this feature it fails with EPERM when using that ioctl - which should=
=20
only come when we don't have the capability CAP_NET_ADMIN. I find it a litt=
le=20
bit irritating since capabilities should not be enabled - but openvz seems =
to=20
activate it for VEs and somebody must enable it using

vzctl set 777 --capability "NET_ADMIN:on" --save

=2E.. which can only be done when the VE is stopped (which is different to =
the=20
=2D-features stuff, which irritates me even more).

So, now we have everything - lets try `brctl addbr br0` - and what would we=
=20
expect to happen? Yes, after that day that it just crash my complete kernel=
 in=20
br_sysfs_addbr.... Good time to stop anything practical using openvz and=20
concentrate on bare source code and ignoring the reality :)

Note for Marek:

proc and sysfs is created using init_ve_proc and init_ve_sysfs for the VE. =
It=20
doesn't look like there is much stuff done there. You must use=20
register_pernet_subsys to create functions which are called when a network=
=20
namespace is created or deleted. This could be used to create the appropria=
te=20
files in /proc/net - should work with /sys too (but haven't found something=
=20
which uses it). It is documented in net/core/net_namespace.c. There are mor=
e=20
namespaces in the current openvz kernel, but I don't think that they are=20
interesting for us.

We should get informed about the removal of a device only in the namespace=
=20
using hard_if_event - so it should not be a problem when the namespace=20
disappears. Also we only use init_net in hard_interface.c when we add a=20
interface - so the actual namespace should not be a problem. But I am a lit=
tle=20
bit curious why we only deactivate the interface in  hard_if_event when it=
=20
gets NETDEV_UNREGISTER. I would think that batman_if->net_dev of that=20
interface isn't valid anymore and we aren't allowed to access it. So removi=
ng=20
it should be the right choice.

I started to write some tests, but then noticed quite fast that (at least i=
n=20
0.2.1) all variables to store the proc filesystem information are global=20
variables - which will not work.

proc_interface_write must also check the net_device structure and not the=20
actual string (if it is allowed to share a batX device between host and VE).

I've added a small (and really unclean) test of the pernet stuff - just to =
get=20
some feeling what must be done to use it. Haven't really done anything usef=
ul=20
due to openvz's way of telling me that it don't want to cooperate... at lea=
st=20
there is now some idea how we (ok... you) can deal with the net namespaces =
:)

Best regards,
	Sven

--Boundary-01=_FF8tLrxyhc7kpQM
Content-Type: text/x-patch;
  charset="UTF-8";
  name="pernet_proctest.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pernet_proctest.patch"

diff -ruN batman-adv-kernelland-0.2.1/proc.c batadv_namespace//proc.c
=2D-- batman-adv-kernelland-0.2.1/proc.c	2010-03-22 21:33:55.000000000 +0000
+++ batadv_namespace//proc.c	2010-04-03 22:06:07.000000000 +0000
@@ -556,44 +556,35 @@
 	.release	=3D single_release,
 };
=20
=2Dvoid cleanup_procfs(void)
+static void __net_exit batmanadv_net_exit(struct net *net)
 {
=2D	if (proc_transt_global_file)
 		remove_proc_entry(PROC_FILE_TRANST_GLOBAL, proc_batman_dir);
=20
=2D	if (proc_transt_local_file)
 		remove_proc_entry(PROC_FILE_TRANST_LOCAL, proc_batman_dir);
=20
=2D	if (proc_originators_file)
 		remove_proc_entry(PROC_FILE_ORIGINATORS, proc_batman_dir);
=20
=2D	if (proc_orig_interval_file)
 		remove_proc_entry(PROC_FILE_ORIG_INTERVAL, proc_batman_dir);
=20
=2D	if (proc_interface_file)
 		remove_proc_entry(PROC_FILE_INTERFACES, proc_batman_dir);
=20
=2D	if (proc_vis_data_file)
 		remove_proc_entry(PROC_FILE_VIS_DATA, proc_batman_dir);
=20
=2D	if (proc_vis_srv_file)
 		remove_proc_entry(PROC_FILE_VIS_SRV, proc_batman_dir);
=20
=2D	if (proc_aggr_file)
 		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
=20
=2D	if (proc_batman_dir)
 #ifdef __NET_NET_NAMESPACE_H
=2D		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
+		remove_proc_entry(PROC_ROOT_DIR, net->proc_net);
 #else
 		remove_proc_entry(PROC_ROOT_DIR, proc_net);
 #endif
 }
=20
=2Dint setup_procfs(void)
+static int __net_init batmanadv_net_init(struct net *net)
 {
 #ifdef __NET_NET_NAMESPACE_H
=2D	proc_batman_dir =3D proc_mkdir(PROC_ROOT_DIR, init_net.proc_net);
+	proc_batman_dir =3D proc_mkdir(PROC_ROOT_DIR, net->proc_net);
 #else
 	proc_batman_dir =3D proc_mkdir(PROC_ROOT_DIR, proc_net);
 #endif
@@ -610,7 +601,7 @@
 		proc_interface_file->proc_fops =3D &proc_interfaces_fops;
 	} else {
 		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_INTERFACES);
=2D		cleanup_procfs();
+		batmanadv_net_exit(net);
 		return -EFAULT;
 	}
=20
@@ -621,7 +612,7 @@
 		proc_orig_interval_file->proc_fops =3D &proc_orig_interval_fops;
 	} else {
 		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_ORIG_INTERVAL);
=2D		cleanup_procfs();
+		batmanadv_net_exit(net);
 		return -EFAULT;
 	}
=20
@@ -631,7 +622,7 @@
 		proc_originators_file->proc_fops =3D &proc_originators_fops;
 	} else {
 		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_ORIGINATORS);
=2D		cleanup_procfs();
+		batmanadv_net_exit(net);
 		return -EFAULT;
 	}
=20
@@ -641,7 +632,7 @@
 		proc_transt_local_file->proc_fops =3D &proc_transt_local_fops;
 	} else {
 		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_LOCAL);
=2D		cleanup_procfs();
+		batmanadv_net_exit(net);
 		return -EFAULT;
 	}
=20
@@ -651,7 +642,7 @@
 		proc_transt_global_file->proc_fops =3D &proc_transt_global_fops;
 	} else {
 		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_GLOBAL);
=2D		cleanup_procfs();
+		batmanadv_net_exit(net);
 		return -EFAULT;
 	}
=20
@@ -662,7 +653,7 @@
 		proc_vis_srv_file->proc_fops =3D &proc_vis_srv_fops;
 	} else {
 		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_VIS_SRV);
=2D		cleanup_procfs();
+		batmanadv_net_exit(net);
 		return -EFAULT;
 	}
=20
@@ -672,7 +663,7 @@
 		proc_vis_data_file->proc_fops =3D &proc_vis_data_fops;
 	} else {
 		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_VIS_DATA);
=2D		cleanup_procfs();
+		batmanadv_net_exit(net);
 		return -EFAULT;
 	}
=20
@@ -682,9 +673,25 @@
 		proc_aggr_file->proc_fops =3D &proc_aggr_fops;
 	} else {
 		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file fail=
ed\n", PROC_ROOT_DIR, PROC_FILE_AGGR);
=2D		cleanup_procfs();
+		batmanadv_net_exit(net);
 		return -EFAULT;
 	}
=20
 	return 0;
 }
+
+static struct pernet_operations batmanadv_net_ops =3D {
+	.init =3D batmanadv_net_init,
+	.exit =3D batmanadv_net_exit,
+};
+
+
+int setup_procfs(void)
+{
+	return register_pernet_subsys(&batmanadv_net_ops);
+}
+
+void cleanup_procfs(void)
+{
+	return unregister_pernet_subsys(&batmanadv_net_ops);
+}

--Boundary-01=_FF8tLrxyhc7kpQM--

--nextPart3043697.Vtg8E1HyIM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLt8FFAAoJEF2HCgfBJntGqsgQAKR3oS4j7tbnGsYCMAG9WdYB
Hnqh3Ij6Q9UiJkdMArwugtVE3+EgseWJF+mVE50z4bcP8Ml9gq3UNI7/37Jb5RZ7
C1SMM5H35f0pLuSgM70wZeqExds0V41k2fFzBoyWvPqi4LmqrsaO2dGEArxarTlM
80cgpy8Lj/oEHocpRvuh/RgUb40yZgZwmtVLZ+Z2anF4EmbyS6A/4TdnAtDQZZv9
1ymT5KKTnc44NS/nHdIRR4pJX3z6S70bI4DADEiDF7SyxkHQ8Dkvm6s+ohEw2nfn
7LNpiW42IkUmKQ6sjGCm9olZBUu3ITE8Q9jJhauseMUS8P0aCEXXKRrbCmgNM751
Q5slMwkOsAZ+3G+n9fdfoNAA+aFTUu1W4qV13DuNlIsZKF6iPOAzoWS5/RsCXThh
d7wSZNSkuAnC67frgeP+jpphNidWFIWErfg2Qa3+XL30BvQXtK09RMiDKO5THns4
NDZsBnVvmfGP/+HbsIKrEkZvsU5icvJwxNvDVSe3U/FYopAEQeLQR2T79efYGU0e
yJ/tvkkCDcl5HSwiatqL5g2sGSYQzAXRP6lMiP0LlncKdK1lbesH8sfSKzzdIF9h
73Owh9cO6nljxxMcGgbIbu/YuzwvhXPTZBsLd6SGJMSqud5W3Z/0dFybBDrnv3Kc
fDxkrznGi2yTQLPqvzmP
=+2eI
-----END PGP SIGNATURE-----

--nextPart3043697.Vtg8E1HyIM--
