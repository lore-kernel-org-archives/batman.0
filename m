From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] ipkg install batman over ssh: postinst failsi
Date: Mon, 17 Nov 2008 01:26:06 +0800
References: <20081116154159.GC26177@aims.ac.za>
	<200811170105.56871.lindner_marek@yahoo.de>
	<20081116171252.GC27634@aims.ac.za>
In-Reply-To: <20081116171252.GC27634@aims.ac.za>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811170126.06574.lindner_marek@yahoo.de>
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

On Monday 17 November 2008 01:12:52 Jan Groenewald wrote:
> OK, they seem to be running due to the nvram settings from the previous
> batmand. I do want them to last over flashes.
>
> This is done from the previous freifunk-batman network migration.

Yes, freifunk-batman does this for you. It definitely is good work - just needs 
some upgrades. It also contains some firewall settings but they open the wrong 
ports (next to some other issues).


> OK, now where is the main config file please? Or is it only nvram, and is
> it still reading those? So I'm down to the command line only? It is fine, I
> just want to understand. I won't be doing the webif soon, but maybe
> later... still learning.

Batman does not need any config file. Every option (if needed) can be supplied 
as parameter when starting the application or running the batman client 
(batmand -c). If you just started I suggets you to have a look at our doc 
section: https://dev.open-mesh.net/batman/wiki/UserDocs

I guess the S66batman startup file reads the nvram variables and generates a 
command line for batman. 

Regards,
Marek

