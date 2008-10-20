From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] current vis revision (1128) not working with
	batmand-experimental
Date: Tue, 21 Oct 2008 01:48:15 +0200
References: <06116ba9eb4ae280303c7073dd272ef8.squirrel@wm.ddmesh.de>
In-Reply-To: <06116ba9eb4ae280303c7073dd272ef8.squirrel@wm.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810210148.15957.axel@open-mesh.net>
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

Hi Stephan, 

I updated  VIS_COMPAT_VERSION in rv1132 of batman-experimental/batman.h to 22 
so that it conforms to VIS_COMPAT_VERSION in trunk/vis/vis.h

first test with my vis-server looks good.

ciao,
axel


On Montag 20 Oktober 2008, Stephan Enderlein (Freifunk Dresden) wrote:
> Hi,
>
> I had some problems with vis which was consuming a lot of memory within
> a short time after running for days. So I decided to use the current
> revision of vis.
> But it seems that the vis does not process any incomming vis packet
> from batman-experimental.
>
> Do you have any idea to get it running?
>
> Best regards
> Stephan
>
> ---------------------------------------
> Dipl.Informatiker(FH) Stephan Enderlein
> Freifunk Dresden
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


