Message-ID: <1206028233.47e287c9bacd6@mail.bluebottle.com>
Date: Thu, 20 Mar 2008 15:50:33 +0000
From: Bastian Bittorf <bittorf@bluebottle.com>
References: <1205401123.47d8f6235d1ae@mail.bluebottle.com>
In-Reply-To: <1205401123.47d8f6235d1ae@mail.bluebottle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Re: faulty dev-batman-adv.ipk
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
To: b.a.t.m.a.n@open-mesh.net

After some days, I found again some
strange things with the provided *.ipk.

On freifunk (v1.6.28) it is impossible to
install the package from a (our) repository.
("couldnt find file xy")

I have found out, that is works when the
keyword "Filenname: xy" ist removed
from the control-file.

"ipkg status batmand-adv"

reports an clean install, but

"ipkg files batmand-adv"

reports no filelist...but its is working.
Maybe the pakagebuilder should also
include the "depends: kmod-tun"-statement
in the control-file.

Thanks and sorry for these "nerv-mails"

bye, Bastian.
