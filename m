From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] problems running batman rev350
Date: Sat, 19 May 2007 22:10:01 +0200
References: <464F0FEF.6090603@gmx.net> <464F3476.9080805@gmx.net>
	<464F4597.4080400@gmx.net>
In-Reply-To: <464F4597.4080400@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705192210.02007.lindner_marek@yahoo.de>
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


Hi,


> ok, it is obviously  now: if i start batmand without the -d option and
> if i do not start 'batmand -c'
> everything runs just smoothly!
>
> i will be experimenting with this in the next days (probably monday) and
> will report my experience.

thanks for your bug report. I just issued 2 patches. Number one reenables core 
dumps on segmentation fault. Batman listens for that signal and tries to 
clean up the routing table, interfaces, etc. Therefore batman exited 
gracefully and the core dump was not created.

But if batman had received SIGSEGV it would print the message "Error - SIGSEGV 
received !". It seems that did not happen ?!
I got the idea that you may be disconnect with your client in the very moment 
when batman tries to write a message into the connection. The kernel would 
recognize the disconnect and sends SIGPIPE to batman which exits as this is 
the default behaviour. The second patch changes that. It is a wild 
guess ...  :-)

Please, try it out.

Regards,
Marek
