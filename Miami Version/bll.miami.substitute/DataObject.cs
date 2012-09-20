using System;
using System.Collections.Generic;
using System.Text;

namespace Miami.Substitute.Bll
{
    public abstract class DataObject
    {
        #region Members

        private bool m_bDirty;

        #endregion

        #region Public Methods

        /// <summary>
        /// Refreshes object data from the database.
        /// </summary>
        /// <remarks>
        /// <para>This methods calls CanRefresh virtual function in order to check
        /// if class has all the needed data for retrieving the rest of the members
        /// from the database, usually ID of the object.
        /// Method sets the Complete flag and resets the Dirty flag.
        /// </para>
        /// <para>
        /// Method calls RefreshObject() virtual function to perfrom actual refresh.
        /// </para>
        /// </remarks>
        /// <seealso cref="SetDirty(bool)"/>
        public void Refresh()
        {
            if (CanRefresh())
            {
                RefreshObject();
                m_bDirty = false;
            }
            else throw new OperationCanceledException("Cannot refresh DataObject, critical data missing!");
        }

        /// <summary>
        /// Updates object in the database.
        /// </summary>
        /// <remarks>
        /// <para>
        /// The method checks the Complete flag to make sure object is complete
        /// and ready to be updated to the database. If object is incomplete an exception is thrown.
        /// </para>
        /// <para>
        /// Method calls UpdateObject() virtual function to perform actual update.
        /// </para>
        /// <para>
        /// A Dirty flag is also being checked and if unset no actual update is made.
        /// This way unneeded database transactions avoided if object was not changed.
        /// In order to force object update to the database a direct call to
        /// UpdateObject() should be made.
        /// </para>
        /// </remarks>
        /// <seealso cref="SetDirty(bool)"/>
        public void Update()
        {
            if (m_bDirty) UpdateObject();
        }

        #endregion

        #region Abstract Methods

        /// <summary>
        /// Overloaded. Perform actual refreshing of the object from the database.
        /// </summary>
        protected abstract void RefreshObject();

        /// <summary>
        /// Overloaded. Perform actual updating of the object from the database.
        /// </summary>
        protected abstract void UpdateObject();

        /// <summary>
        /// Overloaded. Checks if object has all the needed data to identify it in the database and refresh.
        /// </summary>
        protected abstract bool CanRefresh();

        #endregion

        #region Protected Methods

        /// <summary>
        /// Sets the Dirty flag.
        /// </summary>
        /// <seealso cref="SetDirty(bool)"/>
        protected void SetDirty()
        {
            SetDirty(true);
        }

        /// <summary>
        /// Sets or resets the Dirty flag;
        /// </summary>
        /// <param name="bDirty">Value to be set.</param>
        /// <remarks>
        /// <para>
        /// Dirty flag indicates whether the object been modified since the creation or last refresh.
        /// This flag must be set each time any member of the class is changed.
        /// </para>
        /// </remarks>
        protected void SetDirty(bool bDirty)
        {
            m_bDirty = bDirty;
        }

        #endregion
    }
}
