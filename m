From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Using batman
Date: Wed, 6 Jun 2007 12:23:45 +0200
References: <20070606175918.t5afx9tub1ckwk88@wwwstudent.murdoch.edu.au>
In-Reply-To: <20070606175918.t5afx9tub1ckwk88@wwwstudent.murdoch.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706061223.45436.lindner_marek@yahoo.de>
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

> #./batmand interface ath0
>
> I simply get another command line #. Then when I try a:
>
> #ps -e
>
> I cannot see batman running as a process anywhere. Is there something
> that I am missing?

if you don't start batman with debug mode enabled it forks into the 
background. All error messages are logged to syslog. I guess that something 
is wrong with your setup and batman complains about that before exiting. So, 
check your logs or use a debug level to find out.

Good luck,
Marek

