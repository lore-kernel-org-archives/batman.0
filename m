From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Compile batman for fonera 2100
Date: Sun, 15 Jun 2008 02:56:31 +0800
References: <c1004cd20806140759m4a709a70ue8ac380213d3df71@mail.gmail.com>
In-Reply-To: <c1004cd20806140759m4a709a70ue8ac380213d3df71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806150256.31654.lindner_marek@yahoo.de>
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


Hi,

> I'm trying to compile B.A.T.M.A.N. for the fonera 2100 from svn
> http://downloads.open-mesh.net/svn/batman/trunk/batman/ (is in this
> directory the latest svn code for B.A.T.M.A.N. ?), but i don't know how
> cross compile for fonera 2100 ... Can you help me?

if you really want to cross compile the stuff yourself you will need a cross 
compile toolchain. I recommend OpenWRT - batman is included as a package. You 
may want to change the svn URL to the trunk (which is the latest code) and 
adjust the svn revision in batmans OpenWRT makefile.
I suggest you use our precompiled packages which you cqn download from here:
http://downloads.open-mesh.net/batman/development/

Greetings,
Marek
