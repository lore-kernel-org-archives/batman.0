Return-Path: <antoine@7degrees.co.za>
Message-Id: <9B01495A-3D13-463A-B4FC-3C5E129D32EF@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <200907160936.25169.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Thu, 16 Jul 2009 09:45:19 +0200
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
	<200907152050.18936.sven.eckelmann@gmx.de>
	<F0997A98-262F-4E4A-907A-22E1BDC86CB2@7degrees.co.za>
	<200907160936.25169.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


On 16 Jul 2009, at 09:36 , Sven Eckelmann wrote:

>>> Maybe someone sees a problem in my proposal. The only thing I see is
>>> that the
>>> read should appear before locking the current buffer or a "bad
>>> person" (me)
>>> could delay the new buffers for all others by connecting and then
>>> wait for a
>>> long time. I see the same problem in your current implementation.
>>
>> I'm not sure the current implementation performs a read between locks
>> but I agree that the server should not block other connections while
>> waiting for a response from another connection.
> I didn't wanted to say that the current implementation in trunk uses  
> a read,
> but Jonathan Mzengeza's patch does it.


It _is_ Jonathan's patch I'm referring to :-)

As it stands his code does not delay the new buffers for all others if  
someone connects and then waits a long time.

But that is a choopchick and not really important one way or another,  
I think we both agree that switching to blocking sockets is a  
promising idea.

Does anyone with insights into the gooey innards of vis.c have any  
thoughts about this strategy?

  - a
