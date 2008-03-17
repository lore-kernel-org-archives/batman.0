From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. + s3d
Date: Mon, 17 Mar 2008 10:04:54 +0800
References: <1205702775.5906.2.camel@krupskaya.is-a-geek.net.is-a-geek.net>
	<1205703625.6151.1.camel@krupskaya.is-a-geek.net.is-a-geek.net>
In-Reply-To: <1205703625.6151.1.camel@krupskaya.is-a-geek.net.is-a-geek.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803171004.54421.lindner_marek@yahoo.de>
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



> Sorry, in addition to:
> https://dev.open-mesh.net/batman/file/trunk/vis/README
>
> will I be able to use vis + stable B.A.T.M.A.N.?

Unfortunately not.
Batman 0.2 is lacking important features to make the visualization work. 
Therefore the latest vis server works with the latest batman version only.
The vis server will simply ignore the vis packets send by batman 0.2.


> ( I get an error message socket in use..)

That means you have a vis server already running (in the background).

Greetings,
Marek
