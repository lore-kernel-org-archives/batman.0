Message-Id: <E9DE65F5-50B7-494C-8C69-E0A028F2AF0B@gmail.com>
From: Scott Raynel <scottraynel@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v926)
Date: Fri, 25 Jul 2008 15:14:44 +1200
Subject: [B.A.T.M.A.N.] batman-adv-kernelland: Possible kernel deadlock?
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

Hi all,

I'm running batman-adv-kernelland r1102 on linux-2.6.21.5. I've found  
I can fairly reliably deadlock the kernel by disabling and re-enabling  
batman a few times, e.g.

$ echo ath0 > /proc/net/batman-adv/interfaces
wait a while...
$ echo > /proc/net/batman-adv/interfaces
wait a while and repeat.

It appears that this is deadlocking the kernel somehow, as syscalls  
never return, e.g. 'ps' prints the header and then freezes.

Our interface configuration system brings interfaces up and down on re- 
configure, so we'd like the batman interface to be able to withstand  
this use case. I will try to start looking through the code, but I  
thought I'd throw the problem out there to see what others more  
experienced with it think.

Thanks all,

--
Scott Raynel
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand



