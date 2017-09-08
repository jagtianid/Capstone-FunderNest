using System;
using System.Collections;
using System.Reflection;

namespace SoftwareSolutions
{

    public class AuctionItems : CollectionBase
    {
        //private decimal _TotalBids;
        //public decimal TotalBids
        //{
        //    get { return _TotalBids; }
        //    set { _TotalBids = value; }
        //}
        public AuctionItems() { }
        public AuctionItems(AuctionItem[] items)
        {
            AddRange(items);
        }
        public AuctionItems(AuctionItem item)
        {
            Add(item);
        }
        public AuctionItem this[int index]
        {
            get { return (AuctionItem)List[index]; }
            set { List[index] = value; }
        }
        public int Add(AuctionItem value)
        {
            //add to collection an return int code
            return (List.Add(value));
        }
        public void AddRange(AuctionItem[] items)
        {
            foreach (AuctionItem item in items)
                Add(item);
        }
        public void Sort(String SortBy, SortOrderEnum SortOrder)
        {
            GenericComparer comparer = new GenericComparer();
            comparer.SortOrder = SortOrder;
            comparer.SortProperty = SortBy;
            this.InnerList.Sort(comparer);
        }
    }
    public class AuctionItem
    {
        private string _Id;
        private string _Name;
        private string _Description;
        private DateTime _DateOpen;
        private DateTime _DateClose;
        private string _Seller;
        private string _Location;
        private string _Buyer;
        private decimal _BidAmount;
        private int _BidNumber;
        //private string _Category;

        public AuctionItem() { }

        public string Id
        {
            get { return _Id; }
            set { _Id = value; }
        }
        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }
        public DateTime DateOpen
        {
            get { return _DateOpen; }
            set { _DateOpen = value; }
        }
        public DateTime DateClose
        {
            get { return _DateClose; }
            set { _DateClose = value; }
        }
        public string Seller
        {
            get { return _Seller; }
            set { _Seller = value; }
        }
        public string Location
        {
            get { return _Location; }
            set { _Location = value; }
        }
        public string Buyer
        {
            get { return _Buyer; }
            set { _Buyer = value; }
        }
        public decimal BidAmount
        {
            get { return _BidAmount; }
            set { _BidAmount = value; }
        }
        public decimal BidNumber
        {
            get { return _BidNumber; }
            set { _BidNumber = (int)value; }
        }
        //public string Category
        //{
        //    get { return _Category; }
        //    set { _Category = value; }
        //}

        public int CompareTo(object obj, string Property)
        {
            try
            {
                Type type = this.GetType();
                PropertyInfo propertie = type.GetProperty(Property);


                Type type2 = obj.GetType();
                PropertyInfo propertie2 = type2.GetProperty(Property);

                object[] index = null;

                object Obj1 = propertie.GetValue(this, index);
                object Obj2 = propertie2.GetValue(obj, index);

                IComparable Ic1 = (IComparable)Obj1;
                IComparable Ic2 = (IComparable)Obj2;

                int returnValue = Ic1.CompareTo(Ic2);

                return returnValue;
            }
            catch
            {
                return 0; //throw new ArgumentException("CompareTo is not possible !");
            }
        }
    }

    public enum SortOrderEnum
    {
        Ascending,
        Descending
    }

    public class GenericComparer : IComparer
    {
        private String _Property = null;
        private SortOrderEnum _SortOrder = SortOrderEnum.Ascending;

        public String SortProperty
        {
            get { return _Property; }
            set { _Property = value; }
        }

        public SortOrderEnum SortOrder
        {
            get { return _SortOrder; }
            set { _SortOrder = value; }
        }

        public int Compare(object x, object y)
        {
            AuctionItem usr1;
            AuctionItem usr2;

            if (x is AuctionItem)
                usr1 = (AuctionItem)x;
            else
                throw new ArgumentException("Object is not of type Item");

            if (y is AuctionItem)
                usr2 = (AuctionItem)y;
            else
                throw new ArgumentException("Object is not of type Item");

            if (this.SortOrder.Equals(SortOrderEnum.Ascending))
                return usr1.CompareTo(usr2, this.SortProperty);
            else
                return usr2.CompareTo(usr1, this.SortProperty);
        }
    }
}