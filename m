Return-Path: <contact@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <18515809.rdrhCmqhC3@voltaire>
 <572E1EE2.3060806@wifibot.com> <1690340.pptNQMoULa@voltaire>
 <572E2088.7070802@wifibot.com> <572E2F52.6080908@wifibot.com>
From: contact <contact@wifibot.com>
Message-ID: <572E37C7.5040809@wifibot.com>
Date: Sat, 7 May 2016 20:45:27 +0200
MIME-Version: 1.0
In-Reply-To: <572E2F52.6080908@wifibot.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
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

it seems table, I saw a really fast dynamic route creation. With batman 
IV the route took sometime 1 min to come and it was really noisy, i 
tried many settings,
here with V it is good, when I move toward a node it took less than 1 
sec to create a new route and the video stream is not interrupted.

Sometime I loose the route it become a little bit noisy when I stop 
moving  but here I suspect a wifi problem, need to change my channel.

I will make more test by adding other nodes on the path of the robot and 
see how routing is done.

Thank you all :-)

On 07/05/2016 20:09, contact wrote:
> I flashed 3 nodes (2 fixe and 1 mobile streaming 2mbits of video data) 
> ,no crash for the moment.
>
> I am making some test to see if all is ok.
>
> Laurent
>
> On 07/05/2016 19:06, contact wrote:
>> seems ok , I will give a try
>> (I came today at work only to do some mesh testing on moving robots 
>> :-) , never have the time during the week ...)
>>
>> user@ubuntuvm:~/openwrt15011/openwrt$ git -C feeds/routing log
>> commit a3cd8a1729779b8a39336a863ba7f97481e81f5c
>> Author: Marek Lindner <mareklindner@neomailbox.ch>
>> Date:   Sat May 7 20:42:44 2016 +0800
>>
>>     batman-adv: 2016.1 bugfixes & stability updates
>>
>>     Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
>>
>> commit 16ceff232dc58aad799bbb3d98915eb5c78ec2af
>> Author: Axel Neumann <neumann@cgws.de>
>> Date:   Fri May 6 10:35:47 2016 +0200
>>
>>     bmx7: bump version (report channel via topology plugin)
>>
>>
>> On 07/05/2016 19:01, Marek Lindner wrote:
>>> On Saturday, May 07, 2016 18:59:14 contact wrote:
>>>> I just updated I need to recompile and re-flash my nodes it takes
>>>> sometime, can you check please if all your patches are here ?
>>>>
>>>> [..]
>>>>
>>>> Fast-forward
>>>>    ...make-sure-ELP-OGM-orig-MAC-is-updated-on-.patch |  64 
>>>> ++++++++++++
>>>>    ...-adv-Avoid-duplicate-neigh_node-additions.patch |  89 
>>>> +++++++++++++++++
>>>> ...Avoid-nullptr-derefence-in-batadv_v_neigh.patch |  38 +++++++
>>>> ...an-adv-Fix-refcnt-leak-in-batadv_v_neigh_.patch |  81 
>>>> +++++++++++++++
>>>> ...Fix-double-neigh_node_put-in-batadv_v_ogm.patch |  40 ++++++++
>>>> ...initialize-ELP-orig-address-on-secondary-.patch | 110
>>>> +++++++++++++++++++++
>>> Looks good. However, comparing git revisions (as Sven suggested) is 
>>> more
>>> precise than posting such logs.
>>>
>>> Cheers,
>>> Marek
>>
>>
>
>

