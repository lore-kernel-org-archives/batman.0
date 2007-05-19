Message-ID: <464F0FEF.6090603@gmx.net>
Date: Sat, 19 May 2007 16:55:43 +0200
From: Dragan Noveski <perodog@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] problems running batman rev350
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: batman <b.a.t.m.a.n@open-mesh.net>

hi list,
i am new here and just trying to use batman rev350 compiled on 
2.6.21.1-rt3 kernel on ibm-thinkpad-R50e. the rt-patch (for low-latency 
audio work) comes from:

http://people.redhat.com/mingo/realtime-preempt/

i am using a atmel-wlan adapter and the atmel driver from:

git-clone http://honk.sigxcpu.org/git/at76c503a.git/


the driver runs pretty stable, if i use olsrd to join the network here, i use following script to start the protocol:

 #!/bin/sh
    iwconfig eth2 mode ad-hoc essid olsr.freifunk.net channel 10 ap 02:CA:FF:EE
    ifconfig eth2 104.130.30.9
    ifconfig eth2 up
    olsrd


.........

except of some timeouts, which are pretty rarely, that runs good.

i am starting batman with:

#!/bin/bash
    iwconfig eth2 mode ad-hoc essid olsr.freifunk.net channel 10
    ifconfig eth2 105.130.30.9
    ifconfig eth2 up
    sleep 1
    batmand -d 1 -p 105.131.41.5 -r 1 eth2


and

#!/bin/bash
batmand -c -d 2

in another terminal.

when batman starts, the 'batmand -c' script shows, that i am connected 
to another gateway, but not to preferred one:

     Gateway              Router (#/128) 
=> 105.192.99.62      105.130.30.1 ( 3), gw_class 10 - 6 MBit, 
reliability: 0 
   105.192.99.61      105.130.30.1 ( 1), gw_class  7 - 2 MBit, 
reliability: 0 
   105.131.83.5       105.130.30.1 ( 1), gw_class 11 - >6 MBit, 
reliability: 0 
   105.131.41.5       105.130.30.1 ( 2), gw_class 11 - >6 MBit, 
reliability: 0 
   105.192.99.103     105.130.30.1 ( 3), gw_class  7 - 2 MBit, 
reliability: 0 
   105.192.99.192     105.130.30.1 ( 2), gw_class 10 - 6 MBit, 
reliability: 0

...........

this always is a number 105.192.99.....(.62, .103, .192).
this condition than stays for 2 or 3 up to 10 minutes, and in that time 
i cannot even ping the 105.130.30.1 which is the next  point here.

after some minutes, the connection changes, so that 'batmand -c' shows 
that i am connected to 105.131.41.5 and i am able to ping 141.1.1.1.
unfortunately, after some minutes (or even shorter), the batman script 
stops and the terminal is at the prompt again. there is no segfault, 
using 'ulimit -c unlimited' will not produce a core-dump. i suppose that 
this is not a driver bug, cause looking at this moment at 'dmesg', i can 
see that the driver is loaded using the 02:ca:ff:ee:ba:by - if i stop 
batmand and start olsrd, i will be connected to the internet as expected.

i am really not aware of what else information i could provide to you, 
in order to make batmand running stable here, but if you have any idea, 
please let me know!

cheers,
doc
