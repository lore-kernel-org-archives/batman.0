Message-ID: <464F4597.4080400@gmx.net>
Date: Sat, 19 May 2007 20:44:39 +0200
From: Dragan Noveski <perodog@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] problems running batman rev350
References: <464F0FEF.6090603@gmx.net>
	<200705191749.22823.axel@open-mesh.net>	<464F2DB6.3040301@gmx.net>
	<464F3476.9080805@gmx.net>
In-Reply-To: <464F3476.9080805@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Dragan Noveski wrote:
> Dragan Noveski wrote:
>> Axel Neumann wrote:
>>> Hey Dragan,
>>>
>>>  
>>>>  #!/bin/sh
>>>>     iwconfig eth2 mode ad-hoc essid olsr.freifunk.net channel 10 ap
>>>> 02:CA:FF:EE ifconfig eth2 104.130.30.9
>>>>     
>>>
>>> (just to be shure) this should be 02:CA:FF:EE:BA:BE   
>>
>> of course, it was a copy+paste issue...
>>> ..
>>>  
>>>> i am starting batman with:
>>>>
>>>> #!/bin/bash
>>>>     iwconfig eth2 mode ad-hoc essid olsr.freifunk.net channel 10
>>>>     ifconfig eth2 105.130.30.9
>>>>     ifconfig eth2 up
>>>>     sleep 1
>>>>     batmand -d 1 -p 105.131.41.5 -r 1 eth2
>>>>     
>>> can  you start batmand in background with: batmand -r 1 -p 
>>> 105.131.41.5  eth2
>>> instead and tell if the problem continues. This command instantly 
>>> returns your prompt but a:
>>> ps -aux | grep batmand
>>> should show the running main-daemon in the background.
>>>   
>> that looks good in the moment here!
>> it is connecting to the preferred gateway very fast, but again it 
>> stops after some minutes (running 'batmand -c -d 2' in another 
>> terminal).
>>> Also please check that there are no predefined host routes for the 
>>> 105.0.0.0/8 network before you start batmand and after it stopped. 
>>> Meaning a:
>>> route -n | grep ^105 berfore and after the daemon is running should 
>>> only show:
>>> 105.0.0.0       0.0.0.0         255.0.0.0       U     0      
>>> 0        0 eth2
>>> While batmand is running it should of course show routing entries 
>>> for all other known batman nodes but if such host routes are still 
>>> there after the daemon stopped it is a definitive sign for an 
>>> uncorect termination of teh daemon.
>>>   
>> this is strange, after killing batmand, sometimes this command will 
>> give out a long list of nodes, and sometimes it is behaving as you 
>> are expecting it.
>>
>>>  
>>>> #!/bin/bash
>>>> batmand -c -d 2
>>>>
>>>> in another terminal.
>>>>     
>>>
>>> It should of course always be possible to access the debug output 
>>> from the running batmand main-daemon by launching a batmand-client with
>>> batmand -c -d <1-4>
>>> or in batch mode (providing just a single outputpage and returns to 
>>> the prompt) with:
>>> batmand -c -d <1-4> -b
>>> However, it would be interesting to know if the crash is related to 
>>> existence of a batmand-client connecting to the main daemon. For 
>>> example for batmand-0.2.0-rc2-rv350 (and before) debug level 4:
>>> batmand -c -d 4
>>> is known to cause the batmand to crash after a short time and it 
>>> might be possible that this problems also occur with other 
>>> debug-levels.
>>> Try batmand -c -d 1
>>> and batmand -c -d 2
>>> instead.
>>>   
>> when i am running batmand without debug and :
>>
>> 'batmand -c -d 2', batmand is stopping after couple of minutes.
>>
>> trying now to run only batmand without -d option and no client, lets 
>> see for how long it will be running?!
>>
>>
>> cheers,
>> doc
>>
>> p.s. example, batmand was stopping now again and several minutes 
>> after it is stopped:
>>
>> murija2:/home/nowhiskey# route -n | grep ^105
>> 105.192.99.3    105.130.1.67    255.255.255.255 UGH   0      0        
>> 0 eth2
>> 105.131.10.1    105.130.30.1    255.255.255.255 UGH   0      0        
>> 0 eth2
>> 105.0.0.0       0.0.0.0         255.0.0.0       U     0      0        
>> 0 eth2
>> murija2:/home/nowhiskey# ...........
>>
>>
>> 'ps ax' does not shows any batman process running.
>>
>> but my feeling is, that when i do not start 'batmand -c' i will be 
>> connected much more faster. but this statement unfortunately is not 
>> very informative.
>>
>>> ciao,
>>> axel
>>>
>>>
>>>   
>>
> look, i am running batman now for longer than a half hour and it did 
> not stopped.
> it is running with:
>
> #!/bin/bash
>    iwconfig eth2 mode ad-hoc essid olsr.freifunk.net channel 10
>    ifconfig eth2 105.130.30.9
>    ifconfig eth2 up
>    sleep 1
>    batmand -p 105.131.41.5 -r 1 eth2
>
> no batman-client is running, so perhaps really this is the originally 
> problem?!
>
> cheers,
> doc
ok, it is obviously  now: if i start batmand without the -d option and 
if i do not start 'batmand -c'
everything runs just smoothly!

i will be experimenting with this in the next days (probably monday) and 
will report my experience.

cheers,
doc
