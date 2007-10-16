From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] second sliding window size
Date: Tue, 16 Oct 2007 15:17:23 +0200
References: <6850.85.41.146.90.1192461541.squirrel@krisma.oltrelinux.com>
In-Reply-To: <6850.85.41.146.90.1192461541.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710161517.23630.lindner_marek@yahoo.de>
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

> coming from rv674 and approaching to rv719 the very first remarkable
> difference I see is the "second" number (among parenthesis) in title
> column
> Router (#/255 #/64) issuing the command:
>
> batmand -c -d 1 -b (or -d 2 looking for gateways)
>
> There is a second sliding window (size) ?

yes there is. The second column tells you how symetric your connection is. The 
higher the value the more it is symetric.
Expect this column to vanish in the future. It was only for debugging purpose 
as this value is computed into the first column.

Regards,
Marek
