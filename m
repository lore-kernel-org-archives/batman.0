From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] strange default routes
Date: Wed, 17 Oct 2007 20:09:28 +0200
References: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
	<6792.85.41.146.90.1192460098.squirrel@krisma.oltrelinux.com>
	<200710161204.38008.onelektra@gmx.net>
In-Reply-To: <200710161204.38008.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710172009.28758.axel@open-mesh.net>
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

Hello,

Just want to add something to what was said in the latest release mail...
> Another big step forward is our new experimental routing code - we call it
> B.A.T.M.A.N. IV. It takes asymmetric routing into account. Currently we
> have several ideas competing for the final inclusion into the release. Feel
> free to join our testing team.
This other idea is implemented in the batman-experimental branch. The 
implementation has shown to run quite stable and performant during the 
Wireless Community Weekend in Graz. Since then it also runs on our local 
mesh-cloud in Berlin/Friedrichshain. 

No need to be a risky explorer to run it. Just download batmand-exp-0.3  from 
http://downloads.open-mesh.net/batman/development/
and start it (as usual) with:
batmand [options] <(w)lan interface> [additional lan interfaces]

Recently, there is also a documentation included in the sources which can be 
accessed as pdf: http://open-mesh.net/batman/doc/BMX/bmx.pdf
or directly from the latest subversion build: 
http://downloads.open-mesh.net/batman/development/sources/batmand-exp_0.3-alpha-current_sources/doc/bmx/

You are very very welcome to test this :-)

ciao,
/axel

On Dienstag 16 Oktober 2007, elektra wrote:
> > need some hunters ? :)
>
> Soon! If you have a mesh with a couple of boxes with more than one
> batman-interface (linked by ethernet or multiple radios) we'll be more than
> happy to learn about your results.
>
> We just have found one important bug, I think. But it is not fixed yet.
>
> We'll post a message to the list as soon as we think it is fixed and worth
> a try.
>
> Looking forward to the results!
>
> Cheers!
>
> cu elektra
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


