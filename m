Return-Path: <whangarei.hamburg.freifunk.net@gmx.de>
Message-Id: <D8FCFBAF-224C-454D-B86C-D57641FB0DF1@gmx.de>
From: whangarei & opua <whangarei.hamburg.freifunk.net@gmx.de>
In-Reply-To: <5305C654.5020605@meshcoding.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-20-120058491
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 20 Feb 2014 11:20:01 +0100
References: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
 <530521C0.8060705@meshcoding.com>
 <2BC074F4-9F03-4D7D-A0CD-AF66ABB7DAB9@gmx.de>
 <5305308C.5090605@meshcoding.com>
 <F42F9132-14DE-4496-A715-389CF13D6C49@gmx.de>
 <5305C654.5020605@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] Suggestion for routing improvement on poor links
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--Apple-Mail-20-120058491
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On 20.02.2014, at 10:09, Antonio Quartulli wrote:

> Why don't you send this numbers to the ML as well? :)
>
> On 20/02/14 09:00, whangarei & opua wrote:
>> Hi Antonio,
>>
>> have found the output of such a case in my scrollback buffer of the
>> terminal.
>> Have also set hop_penalty to a high value, so don't worry about  
>> some 0
>> TQ values in alternative routes.
>> Please look at the TQ of 101, that will never change...
>
> You have to give these nodes a name: e.g. who is the destination you  
> are
> looking at? who are the direct neighbours you have towards this  
> destination?
>
> Otherwise I cannot understand.
>

The setup is like this:
whangarei is my router, it has one Wlan link to each of this 3  
neighbor router, MAC in the grep, hostname as comment.
This 3 routers are in one large building (across a park) but sometimes  
don't see each other. 2 of them have VPN connects.
I've looked only to the next hop, by grep the lines beginning with the  
MAC of this neighbor routers.
The intension was to get a better feeling of the link quality then  
with the 'iw dev wlan0-1 station dump' output.
So i have observed this behavior...

Have attached the router output as a file, it should be more readable.


--Apple-Mail-20-120058491
Content-Disposition: attachment;
	filename=whangarei.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="whangarei.txt"
Content-Transfer-Encoding: 7bit


root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed    3.070s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    5.810s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]: a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95   31.150s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed    7.510s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b   10.230s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]: a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95   35.580s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed    9.460s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b   12.190s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]: a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95   37.540s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   10.780s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b   13.500s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]: a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95   38.850s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   11.840s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b   14.560s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]: a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95   39.910s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   14.700s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    2.320s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    2.680s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   17.580s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    5.210s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    5.590s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   18.860s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    6.480s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    6.850s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   19.850s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    7.470s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    7.840s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   20.730s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    8.370s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    8.740s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   21.900s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    9.520s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    9.910s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]: 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   28.570s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    1.380s   ( 90) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 80) 76:ea:3a:d6:1d:6b ( 90)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    1.320s   ( 89) 66:66:b3:64:fe:95 [   wlan0-1]: a2:f3:c1:75:6a:ed (  3) 76:ea:3a:d6:1d:6b (  2) 66:66:b3:64:fe:95 ( 89)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   30.270s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    3.090s   ( 90) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 80) 76:ea:3a:d6:1d:6b ( 90)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    3.030s   ( 89) 66:66:b3:64:fe:95 [   wlan0-1]: a2:f3:c1:75:6a:ed (  3) 76:ea:3a:d6:1d:6b (  2) 66:66:b3:64:fe:95 ( 89)
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   32.680s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    0.310s   ( 91) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 83) 76:ea:3a:d6:1d:6b ( 91)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    0.640s   ( 93) 66:66:b3:64:fe:95 [   wlan0-1]: a2:f3:c1:75:6a:ed (  3) 76:ea:3a:d6:1d:6b (  2) 66:66:b3:64:fe:95 ( 93) 
root@whangarei:~#  
root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed # Black-Mesa-Research-Facility
a2:f3:c1:75:6a:ed   39.560s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]: 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed (101)
root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
76:ea:3a:d6:1d:6b    2.130s   ( 91) 76:ea:3a:d6:1d:6b [   wlan0-1]: a2:f3:c1:75:6a:ed ( 86) 76:ea:3a:d6:1d:6b ( 91)
root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 # Kuchenchef-3000
66:66:b3:64:fe:95    2.480s   ( 99) 66:66:b3:64:fe:95 [   wlan0-1]: a2:f3:c1:75:6a:ed (  3) 76:ea:3a:d6:1d:6b (  2) 66:66:b3:64:fe:95 ( 99)
root@whangarei:~#  

--Apple-Mail-20-120058491
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit





>>
>> By,
>> Joe
>>
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed    3.070s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    5.810s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95   31.150s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed    7.510s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b   10.230s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95   35.580s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed    9.460s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b   12.190s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95   37.540s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   10.780s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b   13.500s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95   38.850s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   11.840s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b   14.560s   ( 78) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 78) 76:ea:3a:d6:1d:6b ( 75)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95   39.910s   ( 78) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 78)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   14.700s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    2.320s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    2.680s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   17.580s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    5.210s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    5.590s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   18.860s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    6.480s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    6.850s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   19.850s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    7.470s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    7.840s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   20.730s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    8.370s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    8.740s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   21.900s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    9.520s   ( 81) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 79) 76:ea:3a:d6:1d:6b ( 81)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    9.910s   ( 84) 66:66:b3:64:fe:95 [   wlan0-1]:
>> 76:ea:3a:d6:1d:6b (  1) 66:66:b3:64:fe:95 ( 84)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   28.570s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    1.380s   ( 90) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 80) 76:ea:3a:d6:1d:6b ( 90)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    1.320s   ( 89) 66:66:b3:64:fe:95 [   wlan0-1]:
>> a2:f3:c1:75:6a:ed (  3) 76:ea:3a:d6:1d:6b (  2) 66:66:b3:64:fe:95  
>> ( 89)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   30.270s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    3.090s   ( 90) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 80) 76:ea:3a:d6:1d:6b ( 90)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    3.030s   ( 89) 66:66:b3:64:fe:95 [   wlan0-1]:
>> a2:f3:c1:75:6a:ed (  3) 76:ea:3a:d6:1d:6b (  2) 66:66:b3:64:fe:95  
>> ( 89)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   32.680s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    0.310s   ( 91) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 83) 76:ea:3a:d6:1d:6b ( 91)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    0.640s   ( 93) 66:66:b3:64:fe:95 [   wlan0-1]:
>> a2:f3:c1:75:6a:ed (  3) 76:ea:3a:d6:1d:6b (  2) 66:66:b3:64:fe:95  
>> ( 93)
>> root@whangarei:~#
>> root@whangarei:~# batctl o | grep ^a2:f3:c1:75:6a:ed #
>> Black-Mesa-Research-Facility
>> a2:f3:c1:75:6a:ed   39.560s   (101) a2:f3:c1:75:6a:ed [   wlan0-1]:
>> 66:66:b3:64:fe:95 (  0) 76:ea:3a:d6:1d:6b (  0) a2:f3:c1:75:6a:ed  
>> (101)
>> root@whangarei:~# batctl o | grep ^76:ea:3a:d6:1d:6b # Kundenzentrum
>> 76:ea:3a:d6:1d:6b    2.130s   ( 91) 76:ea:3a:d6:1d:6b [   wlan0-1]:
>> a2:f3:c1:75:6a:ed ( 86) 76:ea:3a:d6:1d:6b ( 91)
>> root@whangarei:~# batctl o | grep ^66:66:b3:64:fe:95 #  
>> Kuchenchef-3000
>> 66:66:b3:64:fe:95    2.480s   ( 99) 66:66:b3:64:fe:95 [   wlan0-1]:
>> a2:f3:c1:75:6a:ed (  3) 76:ea:3a:d6:1d:6b (  2) 66:66:b3:64:fe:95  
>> ( 99)
>> root@whangarei:~#
>>
>> On 19.02.2014, at 23:30, Antonio Quartulli wrote:
>>
>>> On 19/02/14 23:12, whangarei & opua wrote:
>>>> Hi Antonio,
>>>>
>>>> have only a live environment, so only have access to my own  
>>>> router, but
>>>> anyway,
>>>> looks you aware of this issue...
>>>>
>>>> But I have seen no change of the TQ over the time ( up to 180  
>>>> sec) on my
>>>> side with my (maybe old) version of batman.
>>>> Is it an new feature, or it is maybe not working like expected,  
>>>> in my
>>>> old version? :(
>>>>
>>>
>>> I think this is something that is part of batman-adv since the  
>>> beginning
>>> (somebody else can confirm this).
>>>
>>>> Or I'm a little bit blind, sometimes, maybe? ;-)
>>>
>>> I have the feeling that you are not looking at the right entry in  
>>> the
>>> originator table :-)
>>>
>>>
>>> You may want to report some output/real numbers (at different  
>>> times) so
>>> that we can comment on those.
>>>
>>>
>>> Cheers,
>>>
>>> -- 
>>> Antonio Quartulli
>>>
>>
>
>
> -- 
> Antonio Quartulli
>


--Apple-Mail-20-120058491--
