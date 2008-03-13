Message-ID: <47D93815.9070307@leipzig.freifunk.net>
Date: Thu, 13 Mar 2008 15:20:05 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] faulty dev-batman-adv.ipk
References: <1205401123.47d8f6235d1ae@mail.bluebottle.com>
In-Reply-To: <1205401123.47d8f6235d1ae@mail.bluebottle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Bastian Bittorf schrieb:
> The data.tar.gz in the archive is
> not build correct. All file-paths must
> be relative, not absolute:
>
> ./usr/sbin/batmand-adv (at the moment)
> usr/sbin/batmand-adv (correct)

with or without leading "./" - its always the same _relative_ path, i 
think...

root@tetzlav-uplink:~# touch test-without
root@tetzlav-uplink:~# touch ./test-with
root@tetzlav-uplink:~# ls -l test*
-rw-r--r--    1 root     root            0 Mar 13 15:16 test-with
-rw-r--r--    1 root     root            0 Mar 13 15:16 test-without


Regards
tetzlav
